class RatingsController < ApplicationController
  before_action :set_rating, only: [:destroy]

  def new
    @rating = Rating.new
    @restaurants = Restaurant.all
    authorize @rating if defined?(RatingPolicy)
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    authorize @rating if defined?(RatingPolicy)

    if @rating.save
      redirect_to timeline_path, notice: "Avaliação publicada com sucesso."
    else
      @restaurants = Restaurant.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @rating if defined?(RatingPolicy)
    @rating.destroy
    redirect_back fallback_location: timeline_path, notice: "Avaliação apagada."
  end

  private

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(
      :restaurant_id,
      :score,
      :enviroment,
      :service,
      :food_text,
      :price,
      :comment,
      :recommended
    )
  end
end
