class AddSlugToListEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :list_entries, :slug, :string
    add_index :list_entries, :slug, unique: true
  end
end
