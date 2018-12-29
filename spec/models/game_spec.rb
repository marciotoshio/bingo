require 'rails_helper'

RSpec.describe Game, :type => :model do
  describe '#build_board' do
    before { subject.build_board }
    it { expect(subject.board[0]).to eq(nil) }
    it { expect(subject.board[76]).to eq(nil) }

    it 'has numbers from 1 to 75' do
      (1..75).each do |n|
        expect(subject.board[n]).to eq(false)
      end
    end
  end
end
