class AddArtistToListEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :list_entries, :artist, :string
  end
end
