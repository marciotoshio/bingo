class Player < ApplicationRecord
  before_create :build_card

  belongs_to :game

  serialize :card

  def build_card
    self.card = {}
    5.times do |n|
      5.times do |i|
        availables = ((n*15)+1..15*(n+1)).to_a - self.card.keys
        if (n == 2 && i == 2)
          self.card[:X] = true
        else
          self.card[availables[rand(0..availables.size - 1)]] = false
        end
      end
    end
  end

  def select_number(num)
    self.card[num.to_i] = !self.card[num.to_i]
    save
  end

  def reset
    build_card
    save
  end
end
