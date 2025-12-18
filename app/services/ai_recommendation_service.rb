class AiRecommendationService
  def self.call(user_message, restaurants)
    message = normalize(user_message)
    filtered = restaurants

    # CATEGORIAS
    categories = {
      "italiano" => "ital",
      "japon" => "japon",
      "frances" => "franc",
      "brasileiro" => "brasil",
      "portugues" => "portu",
      "mexic" => "mexic",
      "chines" => "chin",
      "indian" => "indi",
      "mediterraneo" => "medite",
      "vegano" => "veg",
      "alemao" => "alem",
      "arabe" => "arab"
    }

    category = categories.find { |k, _| message.include?(k) }
    if category
      keyword = category[1]
      filtered = filtered.select do |r|
        normalize(r.category).include?(keyword)
      end

      return "Não encontramos restaurantes dessa categoria 😕" if filtered.empty?
    end

    # PREÇO (barato / caro)
    max_price = nil
    min_price = nil

    if message.include?("barato")
      max_price = 80
    end

    if message.include?("caro")
      min_price = 150
    end

    # PREÇO "ATÉ X"
    number = message.scan(/\d+/).first
    if number
      number = number.to_i
      max_price = max_price ? [max_price, number].min : number
    end

    # APLICA FILTRO DE PREÇO
    if max_price
      filtered = filtered.select { |r| r.average_price.to_i <= max_price }
    end

    if min_price
      filtered = filtered.select { |r| r.average_price.to_i >= min_price }
    end

    return "Não encontramos restaurantes com esse preço 😕" if filtered.empty?

    # RESPOSTA
    response = "Recomendo estes restaurantes:\n\n"

    filtered.first(3).each do |r|
      response += "• #{r.name} (#{r.category} – preço médio: #{r.average_price})\n"
    end

    response
  end

  def self.normalize(text)
    text.downcase.tr(
      "áàãâéèêíìîóòõôúùûç",
      "aaaaeeeiiioooouuuc"
    )
  end
end
