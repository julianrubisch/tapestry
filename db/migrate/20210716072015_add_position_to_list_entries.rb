class AddPositionToListEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :list_entries, :position, :integer

    add_index :list_entries, [:list_id, :position], unique: true
  end
end
