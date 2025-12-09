class Rating < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  # score geral de 1 a 5
  validates :score, presence: true, inclusion: { in: 1..5 }

  # enviroment / service / food_text / price são opcionais
  # (o usuário escolhe se quer avaliar esses aspectos ou não)
end
