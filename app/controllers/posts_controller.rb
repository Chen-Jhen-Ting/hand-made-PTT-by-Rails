class PostsController < ApplicationController
    
    before_action :find_board, only: [:new,:create]

    def new
        # @board = Board.find(params[:board_id])
        # 先確定這個看板存在
        @post = @board.posts.new
        # @post = Post.new
    end
    def create
        # @board = Board.find(params[:board_id])
        @post = @board.posts.new(clean_params)
        # 以前是Post.new 現在這樣是從 看版 生成的 post  從源頭的角度往下走
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
    
    def find_post
        @post = Post.find(params[:id])
    end

    private
    def find_board
        @board = Board.find(params[:board_id])
    end
    
    def find_post
        @post = Post.find(params[:id])
    end

    def clean_params
        params.require(:post).permit(:title,:content)
    end

    

end
