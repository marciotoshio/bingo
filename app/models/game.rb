# frozen_string_literal: true

class Game < ApplicationRecord
  before_create :build_board

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :players

  serialize :board

  def build_board
    self.board = (1..75).map { |n| [n, false] }.to_h
  end

  def draw
    chosen = board.select { |_, value| value }.keys
    availables = (1..75).to_a - chosen
    self.last_number = availables[rand(0..availables.size - 1)]
    board[last_number] = true
    save
  end

  def last_number_with_column
    return '' if last_number.nil?

    i = (last_number / 15.0).ceil - 1
    col = %w[B I N G O][i]
    "#{col} #{last_number}"
  end

  def reset
    self.last_number = nil
    build_board
    players.each(&:reset)
    save
  end

  def needs_master?
    players.none?(&:master)
  end

  def share_url
    "#{Rails.configuration.app_url}/?game=#{slug}"
  end
end
