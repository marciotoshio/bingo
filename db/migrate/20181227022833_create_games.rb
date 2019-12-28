# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.text :board
      t.integer :last_number

      t.timestamps
    end
  end
end
