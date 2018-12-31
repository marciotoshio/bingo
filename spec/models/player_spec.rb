require 'rails_helper'

RSpec.describe Player, :type => :model do
  before do
    allow(subject).to receive(:save)
    subject.build_card
  end

  describe '#card' do
    it 'has a selected X key' do
      expect(subject.card[:X]).to eq(true)
    end
  end
end
