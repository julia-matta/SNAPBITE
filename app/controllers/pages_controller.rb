class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  # ================= HOME =================
  def home
    redirect_to timeline_path and return if user_signed_in?
  end

  # ================= TIMELINE =================
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

  # ================= EXPLORE =================
  def explore
    # 🔹 opções do filtro de preço (view)
    @price_options = [
      ["Sem limite", ""],
      ["Até R$ 50", 50],
      ["Até R$ 100", 100],
      ["Até R$ 150", 150],
      ["Até R$ 200", 200]
    ]

    @restaurants = Restaurant.all

    # 🔍 Busca por texto
    if params[:query].present?
      @restaurants = @restaurants.where(
        "restaurants.name ILIKE :q
         OR restaurants.infos ILIKE :q
         OR restaurants.category ILIKE :q",
        q: "%#{params[:query]}%"
      )
    end

    # 🍽️ Categoria
    if params[:category].present?
      @restaurants = @restaurants.where(category: params[:category])
    end

    # 💰 Preço médio (CORREÇÃO CRÍTICA)
    if params[:max_price].present? && params[:max_price].to_i.positive?
      @restaurants = @restaurants.where(
        "average_price <= ?",
        params[:max_price].to_i
      )
    end
  end

  # ================= PROFILE =================
  def profile
    @user = current_user
    @ratings_by_category = @user.ratings
                                .includes(:restaurant)
                                .group_by { |r| r.restaurant.category }
  end
end
