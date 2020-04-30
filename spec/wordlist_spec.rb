# frozen_string_literal: true

require 'rails_helper'

describe Wordlist do
  it 'finds the word "Chicken"' do
    expect(Wordlist).to include 'Chicken'
  end

  it 'does not find the word "Xoot"' do
    expect(Wordlist).to_not include 'Xoot'
  end
end
