require 'rails_helper'

RSpec.describe Game, :type => :model do
  before do
    allow(subject).to receive(:save)
    subject.build_board
  end

  describe '#board' do
    it { expect(subject.board[0]).to eq(nil) }
    it { expect(subject.board[76]).to eq(nil) }

    it 'has numbers from 1 to 75' do
      (1..75).each do |n|
        expect(subject.board[n]).to eq(false)
      end
    end
  end

  describe '#draw' do
    before { expect(subject).to receive(:rand).and_return(25) }

    it 'mark the number drawn' do
      subject.draw
      expect(subject.board[26]).to eq(true)
    end
  end

  describe '#last_number_with_column' do
    context 'when last_number is nil' do
      before { allow(subject).to receive(:last_number).and_return(nil) }

      it { expect(subject.last_number_with_column).to eq('') }
    end

    context 'when last_number is 5' do
      before { allow(subject).to receive(:last_number).and_return(5) }

      it { expect(subject.last_number_with_column).to eq('B 5') }
    end

    context 'when last_number is 23' do
      before { allow(subject).to receive(:last_number).and_return(23) }

      it { expect(subject.last_number_with_column).to eq('I 23') }
    end

    context 'when last_number is 37' do
      before { allow(subject).to receive(:last_number).and_return(37) }

      it { expect(subject.last_number_with_column).to eq('N 37') }
    end

    context 'when last_number is 56' do
      before { allow(subject).to receive(:last_number).and_return(56) }

      it { expect(subject.last_number_with_column).to eq('G 56') }
    end

    context 'when last_number is 73' do
      before { allow(subject).to receive(:last_number).and_return(73) }

      it { expect(subject.last_number_with_column).to eq('O 73') }
    end
  end

  describe '#need_game_master' do
    context 'when already have a game master' do
      let(:player_1) { Player.new(master: true) }
      let(:player_2) { Player.new(master: false) }
    end

    context 'when does not have a game master' do
      let(:player_1) { Player.new(master: false) }
      let(:player_2) { Player.new(master: false) }
    end
  end

  describe '#reset' do
    let(:player_1) { Player.new }
    let(:player_2) { Player.new }

    before do
      10.times { subject.draw }
      player_1.build_card
      player_2.build_card
      allow(player_1).to receive(:reset)
      allow(player_2).to receive(:reset)
      subject.players = [player_1, player_2]
    end

    it 'clear everything' do
      subject.reset

      expect(subject.last_number).to be_nil
      expect(player_1).to have_received(:reset)
      expect(player_2).to have_received(:reset)
      (1..75).each do |n|
        expect(subject.board[n]).to eq(false)
      end
    end
  end
end
