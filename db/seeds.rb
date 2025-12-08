# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test).
puts "Limpando banco..."
Restaurant.destroy_all
User.destroy_all

puts "Criando usuário padrão..."
user = User.create!(email: "inventei@example.com", password: "123456")

puts "Criando restaurantes do Chef Léo Paixão..."

Restaurant.create!(
  user: user,
  name: "Ninita",
  category: "Italiano",
  infos: <<~INFOS
    Cidade: Belo Horizonte

    Endereço:
    Rua Bárbara Heliodora, 71, Lourdes, Belo Horizonte, MG
    Telefone: (31) 3292-4237

    Horários:
    - Segunda-feira: 18h–23h
    - Terça a sábado: 12h–17h e 18h–23h
    - Domingo: 12h–17h

    Descrição:
    Restaurante ítalo-mineiro, com massas artesanais e ingredientes locais como ora-pro-nóbis e queijos mineiros.
    Ambiente acolhedor e elegante no coração de Lourdes.

    Destaques:
    - Polenta cremosa
    - Massas frescas com toques mineiros
  INFOS
)

Restaurant.create!(
  user: user,
  name: "Glouton",
  category: "Francês",
  infos: <<~INFOS
    Cidade: Belo Horizonte

    Endereço:
    Rua Bárbara Heliodora, 59, Lourdes, Belo Horizonte, MG
    Telefone: (31) 3292-4237

    Horários:
    - Segunda-feira a sábado: 19h–23h

    Descrição:
    Cozinha franco-mineira que rendeu destaque nacional ao chef Léo Paixão.
    Proposta sofisticada com menu autoral e ingredientes regionais.

    Destaques:
    - Menu degustação com pratos sazonais
    - Alta gastronomia em ambiente intimista
  INFOS
)

Restaurant.create!(
  user: user,
  name: "Nicolau Bar da Esquina",
  category: "Brasileiro",
  infos: <<~INFOS
    Cidade: Belo Horizonte

    Endereço:
    Rua Dicíola Horta, 77, Belvedere, Belo Horizonte, MG
    Telefone: (31) 3292-4237

    Horários:
    - Terça a quinta: 19h–23h
    - Sexta e sábado: 18h–23:30
    - Domingo: 11h–17h

    Descrição:
    Bar de culinária brasileira com releituras criativas, porções generosas e clima descontraído.
    Referência em botecagem gourmet na capital mineira.

    Destaques:
    - Petiscos mineiros autorais
    - Drinks exclusivos
  INFOS
)

Restaurant.create!(
  user: user,
  name: "Macaréu",
  category: "Português",
  infos: <<~INFOS
    Cidade: Belo Horizonte

    Endereço:
    Rua Dicíola Horta, 77, Belvedere, Belo Horizonte, MG
    Telefone: (31) 3292-4237

    Horários:
    - Terça a quinta: 19h–23h
    - Sexta: 19h–23:30
    - Sábado: 12h–16h e 19h–23:30
    - Domingo: 12h–17h

    Descrição:
    Foco em peixes e frutos do mar com inspiração portuguesa e identidade brasileira.
    Serviço elogiado e pratos autorais bem servidos.

    Destaques:
    - Bacalhau confitado
    - Polvo grelhado
  INFOS
)

puts "Finalizado! #{Restaurant.count} restaurantes criados!"
