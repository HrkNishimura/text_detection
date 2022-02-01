class PostsController < ApplicationController
  include PostsHelper

  def index
    gon.vision_api_key = ENV['VISION_API_KEY']
    @post = Post.new
  end

  def create
    if params[:post] == nil
      redirect_to root_path, danger: '画像を選択してください'
      return
    end

    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, success: '画像を保存しました'
    else
      flash.now[:danger] = '画像を保存できませんでした'
      render :index
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image)
  end
end
