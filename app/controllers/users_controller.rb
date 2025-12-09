class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    # Perfil público do usuário
    @ratings_by_restaurant = @user.ratings.includes(:restaurant).group_by(&:restaurant)
  end

  def edit
    authorize @user if defined?(UserPolicy)
  end

  def update
    authorize @user if defined?(UserPolicy)

    if @user.update(user_params)
      redirect_to timeline_path, notice: "Configurações atualizadas com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = params[:id] ? User.find(params[:id]) : current_user
  end

  def user_params
    params.require(:user).permit(:username, :role)
  end
end
