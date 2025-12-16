class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
    @restaurants = Restaurant.all
  end

  def show
    @post = Post.includes(:user, :restaurant, photos_attachments: :blob, comments: :user).find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to timeline_path, notice: "Publicação criada com sucesso!"
    else
      @restaurants = Restaurant.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_back fallback_location: user_path(current_user), notice: "Publicação excluída."
  end

  private

  def post_params
    params.require(:post).permit(
      :caption, :course, :restaurant_id, :check_in,:rating,
      photos: [], menu_times: []
    )
  end
end
