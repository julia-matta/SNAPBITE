class RestaurantsController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  before_action :set_restaurant, only: %i[show edit update destroy]

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show
    authorize @restaurant
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant

    if @restaurant.save
      Post.create!(
        user: current_user,
        restaurant: @restaurant,
        caption: "Novo restaurante cadastrado: #{@restaurant.name}"
      )

      redirect_to @restaurant, notice: "Restaurante criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @restaurant
  end

  def update
    authorize @restaurant

    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: "Restaurante atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @restaurant
    @restaurant.destroy
    redirect_to restaurants_path, notice: "Restaurante apagado com sucesso."
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(
      :name,
      :category,
      :average_price,
      :infos,
      :image_name,
      # :address,
      # :opening_hours,
      # :price_range
    )
  end
end
