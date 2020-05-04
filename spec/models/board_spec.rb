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
      expect(board).to be_all(/[a-z]/)
    end

    it 'creates a non-standard board' do
      expect(board3x5.column_count).to be 3
      expect(board3x5.row_count).to be 5
    end
  end

  context '#has_word?' do
    let(:board) { Board[%w[a b c d], %w[e f g h], %w[i j k l], %w[m n o p]] }

    it 'finds "a"' do
      expect(board).to have_word 'a'
    end

    it 'does not find "z"' do
      expect(board).to_not have_word 'z'
    end

    it 'finds "abcd"/"dcba" (horizontals)' do
      expect(board).to have_word 'abcd'
      expect(board).to have_word 'dcba'
    end

    it 'finds "aeim"/"miea" (verticals)' do
      expect(board).to have_word 'aeim'
      expect(board).to have_word 'miea'
    end

    it 'finds "afkp"/"pkfa" (diagonals)' do
      expect(board).to have_word 'afkp'
      expect(board).to have_word 'pkfa'
    end

    it 'finds "abcdhgfeijklponm"/"mnoplkjiefghdcba" (full snake traversal)' do
      expect(board).to have_word 'abcdhgfeijklponm'
      expect(board).to have_word 'mnoplkjiefghdcba'
    end

    it 'finds "abfijkhd"/"dhkjifba" (mixed traversal)' do
      expect(board).to have_word 'abfijkhd'
      expect(board).to have_word 'dhkjifba'
    end

    it 'does not find "aba" (reused letter)' do
      expect(board).to_not have_word 'aba'
    end
  end

  context '#has_word? with Qu' do
    let(:board) { Board[%w[l i q i], %w[x x x d], %w[x x x x], %w[x x x x]] }

    it 'finds "quid" and "liquid" (handles Qu lookahead)' do
      expect(board).to have_word 'quid'
      expect(board).to have_word 'liquid'
    end
  end

  context '#score' do
    it 'rates simple words correctly' do
      expect(Board.score('dog')).to be 1
      expect(Board.score('dogs')).to be 1
      expect(Board.score('hello')).to be 2
      expect(Board.score('bottle')).to be 3
      expect(Board.score('bottles')).to be 5
      expect(Board.score('democratic')).to be 11
    end

    it 'complains about short words' do
      expect { Board.score('me') }.to raise_error ArgumentError
    end
  end
end
# rubocop:enable Metrics/BlockLength