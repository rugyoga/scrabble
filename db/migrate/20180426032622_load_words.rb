class LoadWords < ActiveRecord::Migration[5.2]
  def change
    File.open('/usr/share/dict/words')
        .map(&:chomp)
        .reject { |word| word =~ /[A-Z]/ }
        .reject { |word| word.size < 2 || word.size > Word::MAX_SIZE }
        .each { |word| Word.create(original: word) }
  end
end
