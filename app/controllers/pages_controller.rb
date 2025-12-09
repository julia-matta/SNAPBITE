class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    return unless user_signed_in?

    if current_user.owner?
      @my_restaurants = current_user.restaurants.limit(5)
      @recent_ratings = Rating
                          .where(restaurant: @my_restaurants)
                          .order(created_at: :desc)
                          .limit(10)
    else # customer
      @recent_restaurants = Restaurant.order(created_at: :desc).limit(5)
      @recent_ratings = Rating.order(created_at: :desc).limit(10)
    end
  end
end
