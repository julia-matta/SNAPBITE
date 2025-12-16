class UsersController < ApplicationController
  before_action :set_user, only: %i[show followers following publications edit update]
  before_action :ensure_current_user!, only: %i[edit update]

  def index
    @users = User.where.not(id: current_user.id).order(created_at: :desc)
    if params[:query].present?
      q = "%#{params[:query]}%"
      @users = @users.where("username ILIKE ? OR email ILIKE ?", q, q)
    end
  end

  def show
    @posts = @user.posts.includes(:restaurant, photos_attachments: :blob).order(created_at: :desc)
  end

  def categories
    @ratings_by_category = @user.ratings.includes(:restaurant).group_by { |r| r.restaurant.category }
  end

  def publications
  @posts = @user.posts.includes(:restaurant, photos_attachments: :blob).order(created_at: :desc)
  end

  def followers
    @followers = @user.followers
  end

  def following
    @following = @user.following
  end

  def edit; end

def update
  if @user.update(user_params)
    redirect_to user_path(@user), notice: "Perfil atualizado."
  else
    render :edit, status: :unprocessable_entity
  end
end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_current_user!
    redirect_to user_path(@user), alert: "Você não tem permissão para fazer isso." unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:username, :email, :profile_picture)
  end
end
