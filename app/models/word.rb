# frozen_string_literal: true

require 'score'
require 'prime_encoding'

# Scrabble word representation
class Word < ApplicationRecord
  extend PrimeEncoding
  MAX_SIZE = 9

  def score
    Score.score(original)
  end

  def encoding
    Word.encoding(original)
  end

  def self.words_by_encoding
    @words_by_encoding ||= Word.all.group_by(&:encoding)
  end

  def self.from_rack(rack)
    rack_encoding = Word.encoding(rack)
    words_by_encoding.select { |encoding, words| Word.can_be_made_from?(rack_encoding, encoding) }.values.flatten
  end

  def can_be_made_from?(rack_encoding)
    can_be_made_from?(rack_encoding, encoding)
  end

  def url
    "http://www.dictionary.com/browse/#{original}"
  end
end
