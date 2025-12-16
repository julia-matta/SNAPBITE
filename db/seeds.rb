puts "Limpando banco..."
Comment.destroy_all
Post.destroy_all
Rating.destroy_all
Checkin.destroy_all
Friendship.destroy_all
Restaurant.destroy_all
User.destroy_all

puts "Criando usuários..."

user = User.create!(
  email: "inventei@example.com",
  password: "123456",
  role: :owner
)

customer = User.create!(
  email: "inventei2@example.com",
  password: "123456",
  role: :customer
)

puts "Criando restaurantes..."

# ------------------- NINITA -------------------
Restaurant.create!(
  user: user,
  name: "Ninita",
  category: "Italiano",
  average_price: 120,
  image_name: "ninita.jpg",
  infos: "Restaurante italiano em Belo Horizonte."
)

# ------------------- GLOUTON -------------------
Restaurant.create!(
  user: user,
  name: "Glouton",
  category: "Francês",
  average_price: 250,
  image_name: "glouton.jpg",
  infos: "Cozinha franco-mineira contemporânea."
)

# ------------------- NICOLAU BAR DA ESQUINA -------------------
Restaurant.create!(
  user: user,
  name: "Nicolau Bar da Esquina",
  category: "Brasileiro",
  average_price: 80,
  image_name: "nicolau.jpg",
  infos: "Bar brasileiro moderno e descontraído."
)

# ------------------- MACARÉU -------------------
Restaurant.create!(
  user: user,
  name: "Macaréu",
  category: "Português",
  average_price: 150,
  image_name: "macareu.jpg",
  infos: "Peixes e frutos do mar com inspiração portuguesa."
)

# ------------------- TASTE VIN -------------------
Restaurant.create!(
  user: user,
  name: "Taste Vin",
  category: "Francês",
  average_price: 200,
  image_name: "taste_vin.jpg",
  infos: "Bistrô francês clássico."
)

# ------------------- KEI -------------------
Restaurant.create!(
  user: user,
  name: "Kei",
  category: "Japonês",
  average_price: 300,
  image_name: "kei.jpg",
  infos: "Alta gastronomia japonesa contemporânea."
)

# ------------------- ANCHO -------------------
Restaurant.create!(
  user: user,
  name: "Ancho",
  category: "Brasileiro",
  average_price: 180,
  image_name: "ancho.jpg",
  infos: "Carnes nobres e parrilla."
)

# ------------------- EL MATADOR -------------------
Restaurant.create!(
  user: user,
  name: "El Matador",
  category: "Mexicano",
  average_price: 130,
  image_name: "el_matador.jpg",
  infos: "Culinária mexicana tradicional."
)

# ------------------- MACAU -------------------
Restaurant.create!(
  user: user,
  name: "Macau",
  category: "Chinês",
  average_price: 140,
  image_name: "macau.jpg",
  infos: "Cozinha chinesa contemporânea."
)

# ------------------- NAMASTÊ -------------------
Restaurant.create!(
  user: user,
  name: "Namastê",
  category: "Indiano",
  average_price: 110,
  image_name: "namaste.jpg",
  infos: "Culinária indiana aromática e tradicional."
)

# ------------------- MITRA -------------------
Restaurant.create!(
  user: user,
  name: "Mitra",
  category: "Mediterrâneo",
  average_price: 160,
  image_name: "mitra.jpg",
  infos: "Cozinha mediterrânea moderna."
)

# ------------------- BEJÍ SUSHI -------------------
Restaurant.create!(
  user: user,
  name: "Bejí Sushi",
  category: "Japonês",
  average_price: 120,
  image_name: "beji_sushi.jpg",
  infos: "Sushi contemporâneo."
)

# ------------------- HOFBRÄUHAUS -------------------
Restaurant.create!(
  user: user,
  name: "Hofbräuhaus",
  category: "Alemão",
  average_price: 170,
  image_name: "hofbrauhaus.webp",
  infos: "Cervejaria alemã tradicional."
)

# ------------------- VILA ÁRABE -------------------
Restaurant.create!(
  user: user,
  name: "Vila Árabe",
  category: "Árabe",
  average_price: 130,
  image_name: "vila_arabe.jpg",
  infos: "Culinária árabe tradicional."
)

puts "Finalizado! #{Restaurant.count} restaurantes criados!"
