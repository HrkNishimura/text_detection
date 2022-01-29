class PostsController < ApplicationController
  include PostsHelper

  def index; end
  
  def result
    # ユーザーがアップした画像をエンコード
    @encoded_image = Base64.strict_encode64(params[:image].read)

    # 画像をVisionAPIに送り、Hashに変換したレスポンスを取得
    @vision_api_responses = request_to_api(@encoded_image)
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
