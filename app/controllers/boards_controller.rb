# frozen_string_literal: true

#
# Controls the game board
#
class BoardsController < ApplicationController
  #
  # App landing page
  #
  def show; end

  #
  # Resets the board to a new random configuration and returns it
  #
  def reset
    session[:board] = Board.random.to_a
    render json: { board: session[:board] }
  end

  #
  # Attempts to find given word in the current board, and validates it
  # against the dictionary
  #
  def find
    word  = params.require(:word).strip.downcase
    error = validate_word(word)
    if error
      render json: { error: error }
    else
      render json: { word: word, score: Board.score(word) }
    end
  end

  private

  def session_board
    session[:board].try { |arr| Board[*arr] }
  end

  # Checks if `word` is valid, and returns a string error message if it isn't
  def validate_word(word)
    return t('.too_short', word: word) unless word.size >= 3
    return t('.missing',   word: word) unless session_board.has_word?(word)
    return t('.bad_word',  word: word) unless Wordlist.include?(word)
  end
end
