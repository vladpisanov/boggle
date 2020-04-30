# frozen_string_literal: true

require 'matrix'

#
# An arbitrary-sized Boggle board
#
class Board < Matrix
  #
  # Factory method to build a random board
  #
  # @param [Integer] width number of columns
  # @param [Integer] height number of rows
  #
  # @return [Board] new randomized board
  #
  def self.random(width = 4, height = 4)
    # NOTE: real Boggle uses dice, so the distribution isn't this uniform,
    #       but we'll keep it simple here
    chars = ('a'..'z').to_a
    build(height, width) { chars.sample }
  end

  #
  # Returns true if specified word can be found on the board
  #
  # @param [String] word to search for
  #
  # @return [Boolean] true if word was found
  #
  def has_word?(word) # rubocop:disable Naming/PredicateName
    each_with_index.any? do |_, x, y|
      has_word_at?(word, x, y)
    end
  end

  private

  # Helper used by `has_word?`. Returns true if string `word` can be found
  # starting at cell (x, y), given a tail of already-visited cells
  def has_word_at?(word, x, y, visited = []) # rubocop:disable Naming/PredicateName
    first, rest = word.split(//, 2)
    return false unless self[x, y] == first

    rest.empty? || neighbors(x, y).without(visited).any? do |nx, ny|
      has_word_at?(rest, nx, ny, visited + [[x, y]])
    end
  end

  # Generates up to 8 neighboring cells that can be reached from cell (x, y)
  # provided they're still within the board's limits
  def neighbors(x, y)
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
      .map { |dx, dy| [x + dx, y + dy] }
      .select { |cx, cy| cx.in?(0...column_size) && cy.in?(0...row_size) }
    # .select { |cell| inside?(*cell) }
  end

  # True if cell (x, y) lies within the board's limits
  # def inside?(x, y)
  #   #x >= 0 && x < column_size && y >= 0 && y < row_size
  #   x.in?(0...column_size) && y.in?(0...row_size)
  # end
end
