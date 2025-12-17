class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to timeline_path and return if user_signed_in?
  end

  def timeline
    ids = current_user.following.pluck(:id)
    ids << current_user.id

    @posts = Post
               .where(user_id: ids)
               .includes(:user, :restaurant, :post_reactions, photos_attachments: :blob)
               .order(created_at: :desc)
  end

  def explore
    @price_options = [
      ["Sem limite", ""],
      ["Até R$ 50", 50],
      ["Até R$ 100", 100],
      ["Até R$ 150", 150],
      ["Até R$ 200", 200]
    ]

    @restaurants = Restaurant.all

    if params[:query].present?
      @restaurants = @restaurants.where(
        "restaurants.name ILIKE :q
         OR restaurants.infos ILIKE :q
         OR restaurants.category ILIKE :q",
        q: "%#{params[:query]}%"
      )
    end

    if params[:category].present?
      @restaurants = @restaurants.where(category: params[:category])
    end

    if params[:max_price].present? && params[:max_price].to_i.positive?
      @restaurants = @restaurants.where("average_price <= ?", params[:max_price].to_i)
    end
  end

  def profile
    @user = current_user
    redirect_to publications_user_path(current_user)

    @ratings_by_category = @user.ratings
                                .includes(:restaurant)
                                .group_by { |r| r.restaurant.category }

    @posts = @user.posts
                  .includes(:restaurant, photos_attachments: :blob)
                  .order(created_at: :desc)
  end
end
