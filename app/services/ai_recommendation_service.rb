class AiRecommendationService
  def self.call(user_message, restaurants)
    message = user_message.downcase

    matches = restaurants.select do |r|
      match = true

      if message.include?("italiano")
        match &&= r.category.downcase.include?("ital")
      end

      if message.include?("japon")
        match &&= r.category.downcase.include?("japon")
      end

      if message.include?("barato")
        match &&= r.average_price.to_i <= 80
      end

      if message.include?("caro")
        match &&= r.average_price.to_i >= 120
      end

      match
    end

    return "Não encontrei restaurantes que combinem com seu pedido 😕" if matches.empty?

    response = "Recomendo estes restaurantes:\n\n"

    matches.first(3).each do |r|
      response += "• #{r.name} (#{r.category} – preço médio: #{r.average_price})\n"
    end

    response
  end
end
