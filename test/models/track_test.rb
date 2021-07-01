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
require "test_helper"

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
