class CreatePhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :phrases do |t|
      t.string :text
      t.text :clients, array: true, default: [] #массив используется для хранения токенов клиентов, которым уже было отослана эта фраза. Массив был выбран для этой цели без каких-либо особенных расчетов
      t.timestamps
    end
    add_index :phrases, :text
    add_index :phrases, :clients, using: 'gin'
  end
end
