# == Schema Information
#
# Table name: tracks
#
#  id         :uuid             not null, primary key
#  audio_url  :string
#  meta       :jsonb
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Track < ApplicationRecord
  include Listable
end
