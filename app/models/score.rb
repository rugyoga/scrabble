class Score
  VALUES = [2, 3, 4, 5, 8, 10].zip(%w[dg bcmp fhvwy k jx qz]).freeze

  def self.generate_values
    VALUES.each_with_object(Hash.new(1)) do |(value, letters), values|
      letters.each_char { |letter| values[letter] = value }
    end
  end

  def self.values
    @values ||= generate_values
  end

  def self.score(word)
    word.each_char.inject(0) { |sum, letter| sum + values[letter] }
  end
end
