puts "Limpando banco..."
Comment.destroy_all
Post.destroy_all
Rating.destroy_all
Checkin.destroy_all
Friendship.destroy_all
Restaurant.destroy_all
User.destroy_all

puts "Criando usuários Owners..."

owner1 = User.create!(
  email: "inventei_owner1@example.com",
  password: "123456",
  role: :owner
)

owner2 = User.create!(
  email: "inventei_owner2@example.com",
  password: "123456",
  role: :owner
)

owner3 = User.create!(
  email: "inventei_owner3@example.com",
  password: "123456",
  role: :owner
)

puts "Criando usuários Customers..."

customer1 = User.create!(
  email: "inventei_customer1@example.com",
  password: "123456",
  role: :customer
)

customer2 = User.create!(
  email: "inventei_customer2@example.com",
  password: "123456",
  role: :customer
)

customer3 = User.create!(
  email: "inventei_customer3@example.com",
  password: "123456",
  role: :customer
)

puts "Criando restaurantes Owner1..."

# ------------------- NINITA -------------------
Restaurant.create!(
  user: owner1,
  name: "Ninita",
  category: "Italiano",
  average_price: 120,
  image_name: "ninita.jpg",
  infos: "Restaurante italiano em Belo Horizonte."
)

# ------------------- GLOUTON -------------------
Restaurant.create!(
  user: owner1,
  name: "Glouton",
  category: "Francês",
  average_price: 250,
  image_name: "glouton.jpg",
  infos: "Cozinha franco-mineira contemporânea."
)

# ------------------- NICOLAU BAR DA ESQUINA -------------------
Restaurant.create!(
  user: owner1,
  name: "Nicolau Bar da Esquina",
  category: "Brasileiro",
  average_price: 80,
  image_name: "nicolau.jpg",
  infos: "Bar brasileiro moderno e descontraído."
)

# ------------------- MACARÉU -------------------
Restaurant.create!(
  user: owner1,
  name: "Macaréu",
  category: "Português",
  average_price: 150,
  image_name: "macareu.jpg",
  infos: "Peixes e frutos do mar com inspiração portuguesa."
)

# ------------------- TASTE VIN -------------------
Restaurant.create!(
  user: owner1,
  name: "Taste Vin",
  category: "Francês",
  average_price: 200,
  image_name: "taste_vin.webp",
  infos: "Bistrô francês clássico."
)

# ------------------- KEI -------------------
Restaurant.create!(
  user: owner1,
  name: "Kei",
  category: "Japonês",
  average_price: 300,
  image_name: "kei.jpg",
  infos: "Alta gastronomia japonesa contemporânea."
)

# ------------------- ANCHO -------------------
Restaurant.create!(
  user: owner1,
  name: "Ancho",
  category: "Brasileiro",
  average_price: 180,
  image_name: "ancho.jpg",
  infos: "Carnes nobres e parrilla."
)

puts "Criando restaurantes Owner2..."

# ------------------- EL MATADOR -------------------
Restaurant.create!(
  user: owner2,
  name: "El Matador",
  category: "Mexicano",
  average_price: 130,
  image_name: "el_matador.jpg",
  infos: "Culinária mexicana tradicional."
)

# ------------------- MACAU -------------------
Restaurant.create!(
  user: owner2,
  name: "Macau",
  category: "Chinês",
  average_price: 140,
  image_name: "macau.jpg",
  infos: "Cozinha chinesa contemporânea."
)

# ------------------- NAMASTÊ -------------------
Restaurant.create!(
  user: owner2,
  name: "Namastê",
  category: "Indiano",
  average_price: 110,
  image_name: "namaste.jpg",
  infos: "Culinária indiana aromática e tradicional."
)

# ------------------- MITRA -------------------
Restaurant.create!(
  user: owner2,
  name: "Mitra",
  category: "Mediterrâneo",
  average_price: 160,
  image_name: "mitra.jpg",
  infos: "Cozinha mediterrânea moderna com massas artesanais."
)

# ------------------- BEJÍ SUSHI -------------------
Restaurant.create!(
  user: owner2,
  name: "Bejí Sushi",
  category: "Japonês",
  average_price: 120,
  image_name: "beji_sushi.jpg",
  infos: "Sushi contemporâneo."
)

# ------------------- HOFBRÄUHAUS -------------------
Restaurant.create!(
  user: owner2,
  name: "Hofbräuhaus",
  category: "Alemão",
  average_price: 170,
  image_name: "hofbrauhaus.webp",
  infos: "Cervejaria alemã tradicional."
)

# ------------------- VILA ÁRABE -------------------
Restaurant.create!(
  user: owner2,
  name: "Vila Árabe",
  category: "Árabe",
  average_price: 130,
  image_name: "vila_arabe.jpg",
  infos: "Culinária árabe tradicional."
)

puts "Criando restaurantes Owner3..."

# ------------------- MOCOTÓ -------------------
Restaurant.create!(
  user: owner3,
  name: "Mocotó",
  category: "Brasileiro",
  average_price: 110,
  image_name: "mocoto.webp",
  infos: "Culinária nordestina brasileira tradicional."
)

# ------------------- LE BIFE -------------------
Restaurant.create!(
  user: owner3,
  name: "Le Bife",
  category: "Francês",
  average_price: 180,
  image_name: "le_bife.webp",
  infos: "Steakhouse de inspiração francesa."
)

# ------------------- MODERN MAMMA OSTERIA -------------------
Restaurant.create!(
  user: owner3,
  name: "Modern Mamma Osteria",
  category: "Italiano",
  average_price: 160,
  image_name: "Modern-Mamma-Osteria.webp",
  infos: "Cozinha italiana moderna com massas artesanais."
)

# ------------------- MANI -------------------
Restaurant.create!(
  user: owner3,
  name: "Mani",
  category: "Italiano",
  average_price: 220,
  image_name: "mani.jpg",
  infos: "Alta gastronomia italiana contemporânea."
)

# ------------------- COCO BAMBU -------------------
Restaurant.create!(
  user: owner3,
  name: "Coco Bambu",
  category: "Brasileiro",
  average_price: 150,
  image_name: "Coco-Bambu.webp",
  infos: "Especializado em frutos do mar."
)

# ------------------- SUSHI MAKOTO -------------------
Restaurant.create!(
  user: owner3,
  name: "Sushi Makoto",
  category: "Japonês",
  average_price: 240,
  image_name: "sushi-makoto.jpg",
  infos: "Sushi tradicional japonês."
)

# ------------------- KADO -------------------
Restaurant.create!(
  user: owner3,
  name: "Kado",
  category: "Japonês",
  average_price: 200,
  image_name: "kado.jpeg",
  infos: "Culinária japonesa tradicional."
)

puts "Finalizado! #{Restaurant.count} restaurantes criados!"
