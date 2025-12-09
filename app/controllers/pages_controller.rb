class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to timeline_path if user_signed_in?
        #     return unless user_signed_in?

        #     if current_user.owner?
        #       @my_restaurants = current_user.restaurants.limit(5)
        #       @recent_ratings = Rating
        #                           .where(restaurant: @my_restaurants)
        #                           .order(created_at: :desc)
        #                           .limit(10)
        #     else # customer
        #       @recent_restaurants = Restaurant.order(created_at: :desc).limit(5)
        #       @recent_ratings = Rating.order(created_at: :desc).limit(10)
  end

  def timeline
    if current_user.friends.any?
      friend_ids = current_user.friends.pluck(:id)
      @ratings = Rating.where(user_id: friend_ids)
                       .order(created_at: :desc)
                       .includes(:user, :restaurant)
    else
      @ratings = Rating.none
    end
  end

  def explore
    @categories = Restaurant::CATEGORIES
    @restaurants = Restaurant.all

    @restaurants = @restaurants.where(category: params[:category]) if params[:category].present?
    @restaurants = @restaurants.where(price_range: params[:price_range]) if params[:price_range].present?
    @restaurants = @restaurants.where("name ILIKE ?", "%#{params[:query]}%") if params[:query].present?
  end

  def profile
    @user = current_user
    @ratings_by_category = @user.ratings.includes(:restaurant)
                                .group_by { |r| r.restaurant.category }

  end
end
