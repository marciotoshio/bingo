# frozen_string_literal: true

class Player < ApplicationRecord
  before_create :build_card

  belongs_to :game

  serialize :card

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def build_card
    self.card = {}
    5.times do |n|
      5.times do |i|
        availables = ((n * 15) + 1..15 * (n + 1)).to_a - card.keys
        if n == 2 && i == 2
          card[:X] = true
        else
          card[availables[rand(0..availables.size - 1)]] = false
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def select_number(num)
    card[num.to_i] = !card[num.to_i]
    save
  end

  def reset
    build_card
    save
  end
end
