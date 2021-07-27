# == Schema Information
#
# Table name: list_entries
#
#  id            :uuid             not null, primary key
#  artist        :string
#  listable_type :string
#  slug          :string
#  title         :string
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  listable_id   :uuid
#
# Indexes
#
#  index_list_entries_on_slug  (slug) UNIQUE
#
require "test_helper"

class ListEntryTest < ActiveSupport::TestCase
  setup do
    @simple_soundcloud_track_url = "https://soundcloud.com/titled/limes"
    @soundcloud_tracks_url = "https://soundcloud.com/titled/tracks"
    @shortened_soundcloud_track_url = "https://bit.ly/3zrFuhM"

    @simple_soundcloud_set_url = "https://soundcloud.com/programmverdichter/sets/barba-curata-ep"
    @shortened_soundcloud_set_url = "https://bit.ly/3gqkf8B"

    @simple_bandcamp_track_url = "https://tropus.bandcamp.com/track/proxima-a"
    @shortened_bandcamp_track_url = "https://bit.ly/3voFhIL"

    @simple_bandcamp_album_url = "https://tropus.bandcamp.com/album/metatropus-ep"
    @shortened_bandcamp_album_url = "https://bit.ly/2TWTFuP"

    VCR.insert_cassette(name)
  end

  teardown do
    VCR.eject_cassette
  end

  test "returns an empty instance if no URL is given" do
    list_entry = ListEntry.init_from_url(url: "", list: lists(:one))
    assert_instance_of(NilClass, list_entry&.listable)
    assert_equal(nil, list_entry.url)
    assert_equal(lists(:one), list_entry.list)
  end

  test "initializes a soundcloud track from a soundcloud URL" do
    list_entry = ListEntry.init_from_url(url: @simple_soundcloud_track_url, list: lists(:one))
    assert_instance_of(SoundCloudTrack, list_entry&.listable)
  end

  test "initializes a soundcloud track from a shortened soundcloud URL" do
    list_entry = ListEntry.init_from_url(url: @shortened_soundcloud_track_url, list: lists(:one))
    assert_instance_of(SoundCloudTrack, list_entry&.listable)
  end

  test "passing a soundcloud track index view raises" do
    assert_raises UnparsableTrackUrlError do
      ListEntry.init_from_url(url: @soundcloud_tracks_url, list: lists(:one))
    end
  end

  test "initializes a soundcloud playlist from a soundcloud set URL" do
    list_entry = ListEntry.init_from_url(url: @simple_soundcloud_set_url, list: lists(:one))
    assert_instance_of(SoundCloudPlaylist, list_entry&.listable)
  end

  test "initializes a soundcloud playlist from a shortened soundcloud set URL" do
    list_entry = ListEntry.init_from_url(url: @shortened_soundcloud_set_url, list: lists(:one))
    assert_instance_of(SoundCloudPlaylist, list_entry&.listable)
  end

  test "initializes a bandcamp track from a bandcamp URL" do
    list_entry = ListEntry.init_from_url(url: @simple_bandcamp_track_url, list: lists(:one))
    assert_instance_of(BandcampTrack, list_entry&.listable)
  end

  test "initializes a bandcamp track from a shortened bandcamp URL" do
    list_entry = ListEntry.init_from_url(url: @shortened_bandcamp_track_url, list: lists(:one))
    assert_instance_of(BandcampTrack, list_entry&.listable)
  end

  test "initializes a bandcamp playlist from a bandcamp album URL" do
    list_entry = ListEntry.init_from_url(url: @simple_bandcamp_album_url, list: lists(:one))
    assert_instance_of(BandcampAlbum, list_entry&.listable)
  end

  test "initializes a bandcamp playlist from a shortened bandcamp album URL" do
    list_entry = ListEntry.init_from_url(url: @shortened_bandcamp_album_url, list: lists(:one))
    assert_instance_of(BandcampAlbum, list_entry&.listable)
  end
end
