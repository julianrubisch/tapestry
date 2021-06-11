class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists, id: :uuid do |t|
      t.string :type

      t.timestamps
    end
  end
end
