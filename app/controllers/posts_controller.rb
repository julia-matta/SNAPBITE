class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
    @restaurants = Restaurant.all
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

  private

  def post_params
    params.require(:post).permit(
      :caption, :course, :restaurant_id, :check_in,
      photos: []
    )
  end
end
