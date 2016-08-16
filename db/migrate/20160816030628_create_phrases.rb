class CreatePhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :phrases do |t|
      t.string :text
      t.text :clients, array: true, default: []
      t.timestamps
    end
    add_index :phrases, :text
    add_index :phrases, :clients, using: 'gin'
  end
end
