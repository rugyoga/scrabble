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

  def self.generate_encoding_to_words
    Word.all.each_with_object({}) do |word, map|
      (map[word.encoding] ||= []) << word
    end
  end

  def self.encoding_to_words
    @encoding_to_words ||= generate_encoding_to_words
  end

  def self.compute(word)
    word.each_char.map { |letter| letter_to_prime[letter] }.reduce(&:*)
  end

  def self.from_rack(rack)
    rack_encoding = compute(rack)
    encoding_to_words
      .select { |encoding, _| (rack_encoding % encoding).zero? }
      .values
      .flatten
      .sort_by(&:score)
      .reverse
  end
end
