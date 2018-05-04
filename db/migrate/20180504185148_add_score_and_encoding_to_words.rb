class AddScoreAndEncodingToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :score, :integer
    add_column :words, :encoding, :integer
  end
end
