class Game < ApplicationRecord
  before_create :build_board

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :players

  serialize :board

  def build_board
    self.board = (1..75).map{ |n| [n, false] }.to_h
  end

  def draw
    chosen = board.select{ |_, value| value }.keys
    availables = (1..75).to_a - chosen
    self.last_number = availables[rand(0..availables.size - 1)]
    board[self.last_number] = true
    save
  end

  def reset
    self.last_number = nil
    build_board
    save
  end
end
