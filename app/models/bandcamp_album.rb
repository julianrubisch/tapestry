# == Schema Information
#
# Table name: playlists
#
#  id         :uuid             not null, primary key
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BandcampAlbum < Playlist
end
