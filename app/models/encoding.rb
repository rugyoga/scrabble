require 'prime'

class Encoding
  def self.primes
    Prime.each(101)
  end

  def self.letters_by_value
    ('a'..'z').sort_by { |letter| Score.letter_to_value[letter] }
  end

  def self.letter_to_prime
    @letter_to_prime ||= Hash[letters_by_value.zip(primes)]
  end

  def self.compute(word)
    word.each_char.map { |letter| letter_to_prime[letter] }.reduce(&:*)
  end

  def self.can_be_made_from?(rack_encoding, word_encoding)
    (rack_encoding % word_encoding).zero?
  end
end
