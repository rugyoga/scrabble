class InitializeScoreAndEncoding < ActiveRecord::Migration[5.2]
  def change
    Word.all.each do |word|
      word.encoding = Encoding.compute(word.original)
      word.score = Score.compute(word.original)
      word.save!
    end
  end
end
