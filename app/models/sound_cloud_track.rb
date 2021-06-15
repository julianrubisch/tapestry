# == Schema Information
#
# Table name: tracks
#
#  id         :uuid             not null, primary key
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SoundCloudTrack < Track
end
