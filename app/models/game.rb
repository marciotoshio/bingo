class Game < ApplicationRecord
  before_create :build_board
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :players
  accepts_nested_attributes_for :players

  serialize :board

  def build_board
    self.board = (1..75).map{ |n| [n, false] }.to_h
  end
end
