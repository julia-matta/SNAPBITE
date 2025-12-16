class RestaurantRecommendationService
  def initialize(user)
    @user = user
  end

  def call
    return Restaurant.none if @user.ratings.empty?

    favorite_categories = @user.ratings
                               .where(score: 4..5)
                               .includes(:restaurant)
                               .map { |r| r.restaurant.category }
                               .uniq

    return Restaurant.none if favorite_categories.empty?

    restaurants = Restaurant
                    .where(category: favorite_categories)
                    .where.not(user: @user)
                    .includes(:ratings)

    restaurants
      .sort_by { |r| -(r.ratings.average(:score) || 0) }
      .first(3)
  end
end
