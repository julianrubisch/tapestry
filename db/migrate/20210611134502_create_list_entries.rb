class CreateListEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :list_entries, id: :uuid do |t|
      t.string :url
      t.string :title
      t.references :list, null: false, foreign_key: true, type: :uuid
      t.string :listable_type
      t.uuid :listable_id

      t.timestamps
    end
  end
end
