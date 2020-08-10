class BoardsController < ApplicationController
    
    
    # rescue_from ActiveRecord::RecordNotFound, with: :not_found
    # acts_as_paranoid
    
    before_action :find_board, only: [:show, :edit, :update, :destroy,:favorite]
                                # 有 only 也有 except

    before_action :authenticate_user!, except: [:index,:show]
    # 我們希望 index and show不檢查是否登入 其他都要
    # require_user_sign_in 這邊我們改成 authenticate_user! 模仿 device套件

    def index 
        @boards = Board.all

        # @boards = Board.available 這行是希望查詢時會去使用scope的功能
        #原本是去找全部資料，現在是去找 deteled_at 沒有紀錄的欄位
        # @boards = Board.where(deleted_at: nil)
    end

    def show
        # @board = Board.find(params[:id]) 被上方得brfore_action 取代掉
        
        #萬一使用者亂查ＩＤ 會給他錯誤訊息
        # begin
            # @board = Board.find(params[:id])
        # rescue
            # render file: '/public/404.html', state: 404
        # end  可以這樣寫
        # @posts = @board.posts
        # 這樣是要查屬於這個看板的文章，左邊@posts 這樣就更意義明確


        @posts = @board.posts.includes(:user)
        # includes(:user) 是要讓他一次查詢post table中 撈出 board_id 一樣的資料
        # includes 會把 這些文章 user_id 打包成一個 array 再去 user table 一次查詢
    end

    def favorite
        current_user.toggle_favorite_boards(@board)
        redirect_to favorites_path, notice: 'ok'
    end

    def new 
        # if user_signed_in?
        #     @board = Board.new   
        # else
        #     reditect_to root_path,notice: '請先登入會員'
        # end
        # 這邊我們定義一個私有方法來處理它
        @board = Board.new  
    end

    def create 
        @board = Board.new(board_params)

        if @board.save
            # ok
            flash[:notice] = '新增成功'
            redirect_to boards_path
        else
            flash[:notice] = '新增失敗'
            render :new
        end
        # Board.create(title: params["title"], intro:['intro'])
        # redirect_to '/boards' 
    end

    def edit
        # @board = Board.find(params[:id]) 被上方得brfore_action 取代掉
    end

    def update
        # @board = Board.find(params[:id]) 被上方得brfore_action 取代掉

        if @board.update(board_params)
            #ok
            flash[:notice] = '更新成功'
            redirect_to boards_path
        else
            #ng
            flash[:notice] = '更新失敗'
            render :edit
        end
    end

    def destroy
        # @board = Board.find(params[:id]) 被上方得brfore_action 取代掉
        @board.update(deleted_at: Time.now)
        # @board.destroy   <-- 這是真刪除
        redirect_to boards_path, notice: '刪除成功'
    end

    private
    #強型別，確實限制要寫入的資料種類
    def board_params
        params.require(:board).permit(:title, :intro)
    end
    # 封裝起來，不給別人用
    # def not_found
        # render file: '/public/404.html', state: 404
    # end
    def find_board
        @board = Board.find(params[:id])
    end
    # 定義出來是為了讓我們不用重複打這行



    # def self.available
    #     where( deleted_at: nil )
        # 查詢deleted_at 是nil 代表沒假刪除的項目
    # end

    # def require_user_sign_in
    #     redirect_to root_path, notice: '請登入' if not user_signed_in?
    # end
    # 這個是用來檢查是否登入
    # 我們需要在很多地方檢查是否登入，可以把它掛到上層類別
end
