class PostsController < ApplicationController
   before_action :load_post,  only: [:show, :edit, :update, :destroy]
   before_action :require_author,  only: [:edit, :update, :destroy]
   
    def index
        @posts = Post.all
    end
    
    def show
        @comments = @post.comments
        @comment = Comment.new(post: @post)
    end
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new post_params
        @post.save
        redirect_to post_path(@post)
    end
    
    def edit
        @post = Post.find params[:id]
    end
    
    def update
        @post = Post.find params[:id]
        @post.update_attributes post_params
        redirect_to post_path(@post)
    end
    
    def destroy
        @post = Post.find params[:id]
        @post.destroy
        redirect_to posts_path
    end
    
    def load_post
      @post = Post.find params[:id]
    end
    
    def post_params 
        params.require(:post).permit(:title, :body)
    end
    
    def require_author
        if @current_user.blank?
            redirect_to post_path(@post), alert: 'You must be logged in to edit posts'
        
        elsif !@current_user || @post.user_id != @current_user.id
            redirect_to post_path(@post), alert: 'You can only edit your own posts'
        end
    end
end