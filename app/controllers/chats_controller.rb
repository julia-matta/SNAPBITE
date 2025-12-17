class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
  end

  def message
    user_message = params[:message]

    # Passa os restaurantes como objetos NÃO string 
    response = AiRecommendationService.call(user_message, Restaurant.all)

    render json: { reply: response }
  end
end
