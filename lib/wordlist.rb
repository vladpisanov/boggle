# frozen_string_literal: true

#
# Miniature interface to the standard Linux wordlist dictionary.
#
# Requirement: must install at least one system dictionary
# (e.g. `apt-get install wamerican`)
#
module Wordlist
  SHARED_DICT_PATH = '/usr/share/dict/words'

  #
  # Returns true if the specified word exists in the dictionary
  #
  # @param [String] word word to search for
  #
  # @return [Boolean] true if the word was found
  #
  def self.include?(word)
    # NOTE: grep parameters are: fixed string match, full line match,
    #       case-insensitive, quiet & exit on first match
    system 'grep', '-Fxiq', word, SHARED_DICT_PATH
  end
end
