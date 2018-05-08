require 'prime'
require 'score'
require 'pry'

module PrimeEncoding
  PRIME_26 = 101

  def letters_by_value
    ('a'..'z').sort_by { |letter| Score.values[letter] }
  end

  def primes
    @primes ||= Hash[letters_by_value.zip(Prime.each(PRIME_26))]
  end

  def encoding(word)
    word.each_char.map { |letter| primes[letter] }.reduce(&:*)
  end

  def can_be_made_from?(rack_encoding, word_encoding)
    (rack_encoding % word_encoding).zero?
  end
end
