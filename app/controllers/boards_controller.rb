class BoardsController < ApplicationController
    before_action :find_board, only: [:favorite, :show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      @boards = Board.all
    end
  
    def show
      @posts = @board.posts.includes(:user)
    end
  
    def favorite
      current_user.toggle_favorite_board(@board)
      respond_to do |format|
        # respond_to 是個方法 yield出什麼東西會根據 html request js request不同給不同東西
        format.html {redirect_to favorites_path, notice: 'OK!'}
        format.json{ render json: {status: @board.favorited_by?(current_user)} }
        # 這邊 .html .json 是對應傳來request是什麼格式
        # 從我的最愛傳來的是html  從愛心傳來的是 json
      end
    end
  
    def new
      @board = Board.new
    end
  
    def create
      @board = Board.new(board_params)
  
      if @board.save
        redirect_to boards_path, notice: "新增成功"
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @board.update(board_params)
        redirect_to boards_path, notice: "更新成功"
      else
        render :edit
      end
    end
  
    def destroy
      @board.destroy
      redirect_to boards_path, notice: "刪除成功"
    end
  
    private
    def find_board
      @board = Board.find(params[:id])
    end
  
    # Strong Parameters
    def board_params
      params.require(:board).permit(:title, :intro)
    end
  end