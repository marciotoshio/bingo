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

  describe '#reset' do
    before do
      subject.card.keys[0..10].each do |key|
        subject.select_number(key)
      end
    end

    it 'clear everything' do
      subject.reset

      subject.card.keys.each do |n|
        expect(subject.card[n]).to eq(false)
      end
    end
  end
end
