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

  describe '#select_number' do
    it 'mark the selected number as true' do
      key = subject.card.keys[10]
      subject.select_number(key)
      expect(subject.card[key]).to eq(true)
    end
  end
end
