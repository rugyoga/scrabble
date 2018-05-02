# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :original
      t.integer :encoding
      t.integer :score

      t.timestamps
    end
  end
end
