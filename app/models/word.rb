# frozen_string_literal: true

require 'score'
require 'encoding'

# Scrabble word representation
class Word < ApplicationRecord
  MAX_SIZE = 9

  def encoding
    Encoding.compute(original)
  end

  def score
    Score.compute(original)
  end

  def self.from_rack(rack)
    rack_encoding = Encoding.compute(rack)
    Word.all.select { |word| word.can_be_made_from?(rack_encoding) }
  end

  def can_be_made_from?(rack_encoding)
    Encoding.can_be_made_from?(rack_encoding, encoding)
  end

  def url
    "http://www.dictionary.com/browse/#{original}"
  end
end
