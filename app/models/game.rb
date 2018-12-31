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

  def last_number_with_column
    i = (last_number / 15.0).ceil - 1
    col = ['B', 'I', 'N', 'G', 'O'][i]
    "#{col} #{last_number}"
  end

  def reset
    self.last_number = nil
    build_board
    players.each { |player| player.reset }
    save
  end
end
