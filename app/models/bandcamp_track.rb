# == Schema Information
#
# Table name: tracks
#
#  id         :uuid             not null, primary key
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BandcampTrack < Track
end
