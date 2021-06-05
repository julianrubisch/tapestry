class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.boolean :public, default: false
      t.boolean :inbox, default: false

      t.timestamps
    end
  end
end
