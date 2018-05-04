# frozen_string_literal: true

require 'score'
require 'encoding'

# Scrabble word representation
class Word < ApplicationRecord
  MAX_SIZE = 9

  before_save do
    self.encoding = Encoding.compute(original)
    self.score = Score.compute(original)
  end

  def self.from_rack(rack)
    Encoding.from_rack(rack)
  end

  def anagram?(candidate)
    encoding == candidate.encoding
  end

  def url
    "http://www.dictionary.com/browse/#{original}"
  end
end
