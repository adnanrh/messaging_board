class PostsController < ApplicationController
  before_action :validate_user_signed_in

  def index
    @posts = Post.by_recent
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def validate_user_signed_in
    redirect_to new_user_session_path unless current_user
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
