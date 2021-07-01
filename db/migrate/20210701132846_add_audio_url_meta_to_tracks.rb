class AddAudioUrlMetaToTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :tracks, :audio_url, :string
    add_column :tracks, :meta, :jsonb
  end
end
