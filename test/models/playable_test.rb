# == Schema Information
#
# Table name: playables
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
#  index_playables_on_slug  (slug) UNIQUE
#
require "test_helper"

class PlayableTest < ActiveSupport::TestCase
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
    playable = Playable.init_from_url(url: "", list: lists(:one))
    assert_instance_of(NilClass, playable&.listable)
    assert_equal(nil, playable.url)
    assert_equal(lists(:one), playable.list)
  end

  test "initializes a soundcloud track from a soundcloud URL" do
    playable = Playable.init_from_url(url: @simple_soundcloud_track_url, list: lists(:one))
    assert_instance_of(SoundCloudTrack, playable&.listable)
  end

  test "initializes a soundcloud track from a shortened soundcloud URL" do
    playable = Playable.init_from_url(url: @shortened_soundcloud_track_url, list: lists(:one))
    assert_instance_of(SoundCloudTrack, playable&.listable)
  end

  test "passing a soundcloud track index view raises" do
    assert_raises UnparsableTrackUrlError do
      Playable.init_from_url(url: @soundcloud_tracks_url, list: lists(:one))
    end
  end

  test "initializes a soundcloud playlist from a soundcloud set URL" do
    playable = Playable.init_from_url(url: @simple_soundcloud_set_url, list: lists(:one))
    assert_instance_of(SoundCloudPlaylist, playable&.listable)
  end

  test "initializes a soundcloud playlist from a shortened soundcloud set URL" do
    playable = Playable.init_from_url(url: @shortened_soundcloud_set_url, list: lists(:one))
    assert_instance_of(SoundCloudPlaylist, playable&.listable)
  end

  test "initializes a bandcamp track from a bandcamp URL" do
    playable = Playable.init_from_url(url: @simple_bandcamp_track_url, list: lists(:one))
    assert_instance_of(BandcampTrack, playable&.listable)
  end

  test "initializes a bandcamp track from a shortened bandcamp URL" do
    playable = Playable.init_from_url(url: @shortened_bandcamp_track_url, list: lists(:one))
    assert_instance_of(BandcampTrack, playable&.listable)
  end

  test "initializes a bandcamp playlist from a bandcamp album URL" do
    playable = Playable.init_from_url(url: @simple_bandcamp_album_url, list: lists(:one))
    assert_instance_of(BandcampAlbum, playable&.listable)
  end

  test "initializes a bandcamp playlist from a shortened bandcamp album URL" do
    playable = Playable.init_from_url(url: @shortened_bandcamp_album_url, list: lists(:one))
    assert_instance_of(BandcampAlbum, playable&.listable)
  end
end
