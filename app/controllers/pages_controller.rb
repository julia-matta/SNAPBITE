class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to timeline_path and return if user_signed_in?
  end

  def timeline
    if current_user.friends.any?
      friend_ids = current_user.friends.pluck(:id)
      @ratings = Rating
                  .where(user_id: friend_ids)
                  .order(created_at: :desc)
                  .includes(:user, :restaurant)
    else
      @ratings = Rating.none
    end
  end

  def explore
    @restaurants = Restaurant.all

    # =========================
    # FILTROS NORMAIS
    # =========================
    if params[:query].present?
      sql_query = <<~SQL
        restaurants.name ILIKE :query
        OR restaurants.infos ILIKE :query
        OR restaurants.category ILIKE :query
      SQL

      @restaurants = @restaurants.where(sql_query, query: "%#{params[:query]}%")
    end

    if params[:category].present?
      @restaurants = @restaurants.where(category: params[:category])
    end

    if params[:max_price].present?
      @restaurants = @restaurants.where(
        "average_price <= ?", params[:max_price]
      )
    end

    # =========================
    # 🤖 IA SIMPLES (RECOMENDAÇÃO)
    # =========================
    if params[:category].present?
      # recomenda 1 ou 2 da categoria clicada
      @recommended_ids = Restaurant
                           .where(category: params[:category])
                           .limit(2)
                           .pluck(:id)
    else
      # recomenda 3 restaurantes gerais
      @recommended_ids = Restaurant
                           .limit(3)
                           .pluck(:id)
    end
  end
end
