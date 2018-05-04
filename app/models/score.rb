class Score
  VALUES = [2, 3, 4, 5, 8, 10].zip(%w[dg bcmp fhvwy k jx qz]).freeze

  def self.generate_letter_to_value
    VALUES.each_with_object(Hash.new(1)) do |(value, letters), values|
      letters.each_char { |letter| values[letter] = value }
    end
  end

  def self.letter_to_value
    @letter_to_value ||= generate_letter_to_value
  end

  def self.compute(word)
    word.each_char.map { |letter| letter_to_value[letter] }.sum
  end
end
