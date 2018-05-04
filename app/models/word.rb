# frozen_string_literal: true

require 'score'
require 'encoding'

# Scrabble word representation
class Word < ApplicationRecord
  before_save do
    self.encoding = Encoding.compute(original)
    self.score = Score.compute(original)
  end

  MAX_SIZE = 9

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
