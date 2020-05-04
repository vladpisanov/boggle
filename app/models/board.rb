# frozen_string_literal: true

require 'matrix'

#
# An arbitrary-sized Boggle board
#
class Board < Matrix
  # The official 16 dice configuration according to
  # https://boardgames.stackexchange.com/questions/29264/boggle-what-is-the-dice-configuration-for-boggle-in-various-languages
  REAL_DICE = [
    %w[R I F O B X], %w[I F E H E Y], %w[D E N O W S], %w[U T O K N D],
    %w[H M S R A O], %w[L U P E T S], %w[A C I T O A], %w[Y L G K U E],
    %w[Q B M J O A], %w[E H I S P N], %w[V E T I G N], %w[B A L I Y T],
    %w[E Z A V N D], %w[R A L E S C], %w[U W I L R G], %w[P A C E M D]
  ].freeze

  #
  # Factory method to build a random board
  #
  # @param [Integer] width number of columns
  # @param [Integer] height number of rows
  #
  # @return [Board] new randomized board
  #
  def self.random(width = 4, height = 4)
    build(height, width).with_index do |_, i|
      REAL_DICE[i % REAL_DICE.size].sample
    end
  end

  #
  # Returns true if specified word can be found on the board
  #
  # @param [String] word to search for
  #
  # @return [Boolean] true if word was found
  #
  def has_word?(word) # rubocop:disable Naming/PredicateName
    word = word.upcase
    each_with_index.any? do |_, x, y|
      has_word_at?(word, x, y)
    end
  end

  #
  # Returns the score for a given word
  #
  # @param [String] word word to be valued
  #
  # @return [Integer] number of points
  #
  def self.score(word)
    case word.size
    when 0..2 then raise ArgumentError, I18n.t('models.board.errors.too_short')
    when 3, 4 then 1
    when 5    then 2
    when 6    then 3
    when 7    then 5
    else      11
    end
  end

  private

  # Helper used by `has_word?`. Returns true if string `word` can be found
  # starting at cell (x, y), given a tail of already-visited cells
  def has_word_at?(word, x, y, visited = []) # rubocop:disable Naming/PredicateName
    first, rest = word.split(//, 2)
    return false unless self[x, y] == first

    # Special case: if the current letter is "q" and the next one is "u",
    # vacuously allow the "u" (since Q is usually followed by U in English)
    rest.delete_prefix!('U') if first == 'Q'

    rest.empty? || neighbors(x, y).without(visited).any? do |nx, ny|
      has_word_at?(rest, nx, ny, visited + [[x, y]])
    end
  end

  # Generates up to 8 neighboring cells that can be reached from cell (x, y)
  # provided they're still within the board's limits
  def neighbors(x, y)
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
      .map    { |dx, dy| [x + dx, y + dy] }
      .select { |cx, cy| cx.in?(0...row_size) && cy.in?(0...column_size) }
  end
end
