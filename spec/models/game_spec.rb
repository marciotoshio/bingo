# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
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

  describe '#needs_master?' do
    context 'when does not have players' do
      it { expect(subject.needs_master?).to eq(true) }
    end

    context 'when already have a game master' do
      let(:player1) { Player.new(master: true) }
      let(:player2) { Player.new(master: false) }

      before { subject.players = [player1, player2] }

      it { expect(subject.needs_master?).to eq(false) }
    end

    context 'when does not have a game master' do
      let(:player1) { Player.new(master: false) }
      let(:player2) { Player.new(master: false) }

      before { subject.players = [player1, player2] }

      it { expect(subject.needs_master?).to eq(true) }
    end
  end

  describe '#reset' do
    let(:player1) { Player.new }
    let(:player2) { Player.new }

    before do
      10.times { subject.draw }
      player1.build_card
      player2.build_card
      allow(player1).to receive(:reset)
      allow(player2).to receive(:reset)
      subject.players = [player1, player2]
    end

    it 'clear everything' do
      subject.reset

      expect(subject.last_number).to be_nil
      expect(player1).to have_received(:reset)
      expect(player2).to have_received(:reset)
      (1..75).each do |n|
        expect(subject.board[n]).to eq(false)
      end
    end
  end

  describe '#share_url' do
    let(:slug) { 'rspec-bingo' }

    before { allow(subject).to receive(:slug).and_return(slug) }

    it { expect(subject.share_url).to eq("http://bingo.test/?game=#{slug}") }
  end
end
