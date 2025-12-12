class CheckinsController < ApplicationController
  before_action :authenticate_user!   # assume Devise; se não usa Devise, adapte
  before_action :set_restaurant

  def create
    @checkin = @restaurant.checkins.build(user: current_user)

    if @checkin.save
      flash[:notice] = "Check-in registrado! ✅"
    else
      flash[:alert] = "Não foi possível registrar o check-in."
    end

    redirect_back(fallback_location: explore_path)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
