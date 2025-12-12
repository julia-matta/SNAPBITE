puts "Limpando banco..."
Restaurant.destroy_all
User.destroy_all

puts "Criando usuário owner..."
user = User.create!(email: "inventei@example.com", password: "123456", role: :owner)

puts "Criando usuário customer..."
customer = User.create!(email: "inventei2@example.com", password: "123456", role: :customer)

puts "Criando restaurantes do Chef Léo Paixão..."

# ------------------- NINITA -------------------
Restaurant.create!(
  user: user,
  name: "Ninita",
  category: "Italiano",
  average_price: 120,
  image_name: "ninita.jpg",
  infos: <<~INFOS
    Cidade: Belo Horizonte

    Endereço:
    Rua Bárbara Heliodora, 71, Lourdes, Belo Horizonte, MG

    Descrição:
    Restaurante ítalo-mineiro com massas artesanais e ingredientes locais.
  INFOS
)

# ------------------- GLOUTON -------------------
Restaurant.create!(
  user: user,
  name: "Glouton",
  category: "Francês",
  average_price: 250,
  image_name: "glouton.jpg",
  infos: <<~INFOS
    Cidade: Belo Horizonte

    Descrição:
    Cozinha franco-mineira sofisticada com menu autoral do chef Léo Paixão.
  INFOS
)

# ------------------- NICOLAU -------------------
Restaurant.create!(
  user: user,
  name: "Nicolau Bar da Esquina",
  category: "Brasileiro",
  average_price: 80,
  image_name: "nicolau.jpg",
  infos: <<~INFOS
    Cidade: Belo Horizonte

    Descrição:
    Bar de culinária brasileira com releituras criativas e clima descontraído.
  INFOS
)

# ------------------- MACARÉU -------------------
Restaurant.create!(
  user: user,
  name: "Macaréu",
  category: "Português",
  average_price: 150,
  image_name: "macareu.jpg",
  infos: <<~INFOS
    Cidade: Belo Horizonte

    Descrição:
    Foco em peixes e frutos do mar com inspiração portuguesa.
  INFOS
)

puts "Finalizado! #{Restaurant.count} restaurantes criados!"
