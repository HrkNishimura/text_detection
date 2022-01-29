class PostsController < ApplicationController
  def index
    @post = Post.new
  end

  def create
    if params[:post] == nil
      redirect_to root_path, alert: '画像をアップロードしてください'
      return
    end

    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: '画像を保存しました'
    else
      flash.now[:alert] = '画像を保存できませんでした'
      render :index
    end
  end
  
  private
  
    def post_params
      params.require(:post).permit(:image)
    end
end
