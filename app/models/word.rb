# frozen_string_literal: true

require 'score'
require 'encoding'

# Scrabble word representation
class Word < ApplicationRecord
  MAX_SIZE = 9

  def score
    Score.compute(original)
  end

  def encoding
    Encoding.compute(original)
  end

  def self.generate_encoding_cache
    Word.all.group_by(&:encoding)
  end

  def self.encoding_cache
    @encoding_cache ||= generate_encoding_cache
  end

  def self.from_rack(rack)
    rack_encoding = Encoding.compute(rack)
    encoding_cache.select { |encoding, words| Encoding.can_be_made_from?(rack_encoding, encoding) }.values.flatten
  end

  def can_be_made_from?(rack_encoding)
    Encoding.can_be_made_from?(rack_encoding, encoding)
  end

  def url
    "http://www.dictionary.com/browse/#{original}"
  end
end
