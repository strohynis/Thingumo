class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @posts = Post.where(user_id: @post.user.id) # 投稿詳細ページの関連投稿の欄用
    @comments = @post.comments.page(params[:page]).per(10).reverse_order
    @comment = @post.comments.build # 投稿全体へのコメント投稿用の変数
    @comment_reply = @post.comments.build # コメントに対する返信用の変数
    @special_answer = @post.special_answers.find_by(approval: true)
    if current_user != @post.user
      @post.increment!(:view_count)
    end
  end

  def new
    @categories = Category.all
    @post = current_user.posts.build # 投稿フォームのform_with用
    # @post.post_images.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '送信しました'
      redirect_to root_url    
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '送信できませんでした'
      render 'posts/new'
    end
  end
    
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:success] = 'メッセージを削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :category_id, { images: [] })
  end
end
