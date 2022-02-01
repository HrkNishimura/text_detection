class PostsController < ApplicationController
  include PostsHelper

  def index
    gon.vision_api_key = ENV['VISION_API_KEY']
  end
  
  def result
    if params[:image].nil?
      redirect_to root_path, danger: '画像を選択してください'
      return
    end
    # ユーザーがアップした画像をエンコード
    @encoded_image = Base64.strict_encode64(params[:image].read)

    # 画像をVisionAPIに送り、Hashに変換したレスポンスを取得
    @vision_api_responses = request_to_api(@encoded_image)

    @image = "data:image/jpeg;base64,#{@encoded_image}"
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
