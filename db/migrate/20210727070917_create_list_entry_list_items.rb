class CreateListEntryListItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :list_entries, :list_id, type: :uuid
    remove_column :list_entries, :position, type: :integer

    create_table :list_entry_list_items, id: :uuid do |t|
      t.integer :position
      t.references :list, null: false, foreign_key: true, type: :uuid
      t.references :list_entry, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
