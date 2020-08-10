class PostsController < ApplicationController
    
    before_action :find_board, only: [:new,:create]
    before_action :authenticate_user!, except: [:show]
    # 除了觀看文章，其他行為都需要有登入
    def show
        @post = Post.find(params[:id])
        
        @comment = @post.comments.new
        @comments =@post.comments
        # 從文章的角度新增評論
    end
    def new
        # @board = Board.find(params[:board_id])
        # 先確定這個看板存在
        @post = @board.posts.new
        # @post = Post.new
    end
    def create
        
        # @board = Board.find(params[:board_id])
        @post = @board.posts.new(post_params)
        # 以前是Post.new 現在這樣是從 看版 生成的 post  從源頭的角度往下走

        # @post.user = current_user  
        # 這一行可以在創建文章的時候把user_id 塞入 這樣很醜，用merge方法改寫，看下方
        if @post.save
            redirect_to @board,notice: '文章新增成功'
            # rediret_to board_path(board)
            # rediret_to board_path(board.id)
            # rediret_to board_path(id: board.id)
            # rediret_to board    這些都會動，用第一和第四比較好
        else
            flash[:notice] = '文章新增失敗'
            render :new
        end
    end

    def edit
        # @post = Post.find(id: params[:id], user: current_user)
        # 這邊修改文章需要限制只能改自己的文章，所以加入user: current_user

        @post = current_user.posts.find(params[:id])
        # 從登入者的角度去找自己的文章
    end

    def update
        @post = current_user.posts.find(params[:id])
        if @post.update(post_params)
            redirect_to @post, notice: '文章更新成功'
            # redirect_to post_path(@post) 這個路徑跟上面相同，因為rails 會去猜路徑
        else
            render :edit
        end
    end
    
    def destroy
        @post = current_user.posts.find(params[:id])
        @post.destroy
        flash[:notice]='文章已刪除'
        redirect_to board_path(@post.board_id)
    end

    private
    def find_board
        @board = Board.find(params[:board_id])
    end
    

    def post_params
        params.require(:post).permit(:title,:content).merge(user: current_user)
        # 後面的.merge(user: current_user)  user: 這邊是belongs_to 做出來的方法，會轉成 user_id
        # current_user 是登入者的資訊，這邊會把整包轉成 user_id: current_user.id 之後可以存到文章的user_id欄位
    end
end
