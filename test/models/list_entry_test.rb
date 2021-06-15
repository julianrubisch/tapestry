# == Schema Information
#
# Table name: list_entries
#
#  id            :uuid             not null, primary key
#  artist        :string
#  listable_type :string
#  title         :string
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  list_id       :uuid             not null
#  listable_id   :uuid
#
# Indexes
#
#  index_list_entries_on_list_id  (list_id)
#
# Foreign Keys
#
#  fk_rails_...  (list_id => lists.id)
#
require "test_helper"

class ListEntryTest < ActiveSupport::TestCase
  setup do
    @simple_soundcloud_url = "https://soundcloud.com/titled/limes"
    @soundcloud_track_url = "https://soundcloud.com/titled/tracks"
    @shortened_soundcloud_url = "https://bit.ly/3zrFuhM"

    VCR.insert_cassette(name)
  end

  teardown do
    VCR.eject_cassette
  end

  test "creates a soundcloud track from a soundcloud URL" do
    list_entry = ListEntry.create_from_url(url: @simple_soundcloud_url, list: lists(:one))
    assert_instance_of(SoundCloudTrack, list_entry&.listable)
  end

  test "creates a soundcloud track from a shortened soundcloud URL" do
    list_entry = ListEntry.create_from_url(url: @shortened_soundcloud_url, list: lists(:one))
    assert_instance_of(SoundCloudTrack, list_entry&.listable)
  end

  test "passing a soundcloud track index view raises" do
    assert_raises UnparsableTrackUrlError do
      ListEntry.create_from_url(url: @soundcloud_track_url, list: lists(:one))
    end
  end
end
