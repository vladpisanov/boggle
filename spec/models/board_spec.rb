# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe Board do
  context '#random' do
    let(:board)    { Board.random }
    let(:board3x5) { Board.random(3, 5) }

    it 'creates a standard randomized board' do
      expect(board.row_count).to be 4
      expect(board.column_count).to be 4
      expect(board).to be_all(/[A-Z]/)
    end

    it 'creates a non-standard board' do
      expect(board3x5.column_count).to be 3
      expect(board3x5.row_count).to be 5
    end
  end

  context '#has_word?' do
    let(:board) { Board[%w[A B C D], %w[E F G H], %w[I J K L], %w[M N O P]] }

    it 'finds "A"' do
      expect(board).to have_word 'A'
    end

    it 'does not find "Z"' do
      expect(board).to_not have_word 'Z'
    end

    it 'finds "ABCD"/"DCBA" (horizontals)' do
      expect(board).to have_word 'ABCD'
      expect(board).to have_word 'DCBA'
    end

    it 'finds "AEIM"/"MIEA" (verticals)' do
      expect(board).to have_word 'AEIM'
      expect(board).to have_word 'MIEA'
    end

    it 'finds "AFKP"/"PKFA" (diagonals)' do
      expect(board).to have_word 'AFKP'
      expect(board).to have_word 'PKFA'
    end

    it 'finds "ABCDHGFEIJKLPONM"/"MNOPLKJIEFGHDCBA" (full snake traversal)' do
      expect(board).to have_word 'ABCDHGFEIJKLPONM'
      expect(board).to have_word 'MNOPLKJIEFGHDCBA'
    end

    it 'finds "ABFIJKHD"/"DHKJIFBA" (mixed traversal)' do
      expect(board).to have_word 'ABFIJKHD'
      expect(board).to have_word 'DHKJIFBA'
    end

    it 'does not find "ABA" (reused letter)' do
      expect(board).to_not have_word 'ABA'
    end
  end

  context '#has_word? with Qu' do
    let(:board) { Board[%w[L I Q I], %w[X X X D], %w[X X X X], %w[X X X X]] }

    it 'finds "QUID" and "LIQUID" (handles Qu lookahead)' do
      expect(board).to have_word 'QUID'
      expect(board).to have_word 'LIQUID'
    end
  end

  context '#score' do
    it 'rates simple words correctly' do
      expect(Board.score('DOG')).to be 1
      expect(Board.score('DOGS')).to be 1
      expect(Board.score('HELLO')).to be 2
      expect(Board.score('BOTTLE')).to be 3
      expect(Board.score('BOTTLES')).to be 5
      expect(Board.score('DEMOCRATIC')).to be 11
    end

    it 'complains about short words' do
      expect { Board.score('ME') }.to raise_error ArgumentError
    end
  end
end
# rubocop:enable Metrics/BlockLength
