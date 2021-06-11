class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists, id: :uuid do |t|
      t.string :name
      t.references :owner, null: false, type: :uuid, foreign_key: { to_table: :users }
      t.boolean :public, default: false
      t.boolean :inbox, default: false

      t.timestamps
    end
  end
end
