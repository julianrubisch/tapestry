class RenameListEntriesToPlayables < ActiveRecord::Migration[6.1]
  def change
    rename_table :list_entries, :playables
    rename_table :list_entry_list_items, :playable_list_items

    rename_column :playable_list_items, :list_entry_id, :playable_id
  end
end
