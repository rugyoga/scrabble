# frozen_string_literal: true

require 'prime'

# Scrabble word representation
class Word < ApplicationRecord
  before_save :compute_encoding_and_score

  MAX_SIZE = 9
  VALUES = [2, 3, 4, 5, 8, 10].zip(%w[dg bcmp fhvwy k jx qz]).freeze

  def self.primes
    Prime.each(101)
  end

  def self.letters
    ('a'..'z').sort_by { |letter| letter_to_value[letter] }
  end

  def self.letter_to_prime
    @letter_to_prime ||= Hash[letters.zip(primes)]
  end

  def self.generate_letter_to_value
    VALUES.each_with_object(Hash.new(1)) do |(value, letters), values|
      letters.each_char { |letter| values[letter] = value }
    end
  end

  def self.generate_encoding_to_words
    Word.all.each_with_object({}) do |word, map|
      (map[word.encoding] ||= []) << word
    end
  end

  def self.letter_to_value
    @letter_to_value ||= generate_letter_to_value
  end

  def self.encoding_to_words
    @encoding_to_words ||= generate_encoding_to_words
  end

  def self.encode(word)
    word.each_char.map { |letter| letter_to_prime[letter] }.reduce(&:*)
  end

  def self.score(word)
    word.each_char.map { |letter| letter_to_value[letter] }.sum
  end

  def self.from_rack(rack)
    rack_encoding = encode(rack)
    encoding_to_words
      .select { |encoding, _| (rack_encoding % encoding).zero? }
      .values
      .flatten
      .sort_by(&:score)
      .reverse
  end

  def compute_encoding_and_score
    self.encoding = Word.encode(original)
    self.score = Word.score(original)
  end

  def anagram?(candidate)
    encoding == candidate.encoding
  end

  def url
    "http://www.dictionary.com/browse/#{original}"
  end
end
