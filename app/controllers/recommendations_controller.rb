class RecommendationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = RestaurantRecommendationService
                     .new(current_user)
                     .call
  end
end
