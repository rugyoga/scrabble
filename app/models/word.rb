# frozen_string_literal: true

require 'prime'

# Scrabble word representation
class Word < ApplicationRecord
  before_save :compute_encoding_and_score

  MAX_SIZE = 7
  VALUES = [[2, 'dg'],
            [3, 'bcmp'],
            [4, 'fhvwy'],
            [5, 'k'],
            [8, 'jx'],
            [10, 'qz']].freeze

  def self.primes
    @primes ||= Prime.each(101).to_a
  end

  def self.letters
    @letters ||= ('a'..'z').sort_by { |letter| scores[letter] }
  end

  def self.encoding
    @encoding ||= Hash[letters.zip(primes)]
  end

  def self.generate_scores
    scores = Hash.new(1)
    VALUES.each do |value, letters|
      letters.each_char { |char| scores[char] = value }
    end
    scores
  end

  def self.scores
    @scores ||= generate_scores
  end

  def self.generate_cache
    cache = {}
    Word.all.each { |word| (cache[word.encoding] ||= []) << word }
    cache
  end

  def self.cache
    @cache ||= generate_cache
  end

  def self.encode(word)
    word.each_char.map { |char| encoding[char] }.reduce(&:*)
  end

  def self.score(word)
    word.each_char.map { |char| scores[char] }.sum
  end

  def compute_encoding_and_score
    self.encoding = Word.encode(original)
    self.score = Word.score(original)
  end

  def self.from_rack(rack)
    encoding = encode(rack)
    words = []
    cache.each do |hash, words_with_hash|
      words += words_with_hash if (encoding % hash).zero?
    end
    words.sort_by(&:score).reverse
  end

  def anagram?(candidate)
    encoding == candidate.encoding
  end

  def url
    "http://www.dictionary.com/browse/#{original}"
  end
end
