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

require "open-uri"

class ListEntry < ApplicationRecord
  belongs_to :list

  delegated_type :listable, types: %w[Track Playlist]

  validates :url, :title, :artist, presence: true

  def self.create_from_url(url:, list:)
    URI.open(url) do |uri|
      base_uri = uri.base_uri

      listable_type = case base_uri.to_s
      when /soundcloud.com\/(?<artist>.+)\/tracks/
        raise UnparsableTrackUrlError
      when /soundcloud.com\/(?<artist>.+)\/sets\/(?<title>.+)/
        SoundCloudPlaylist
      when /soundcloud.com\/(?<artist>.+)\/(?<title>.+)/
        SoundCloudTrack
      when /(?<artist>.+)\.bandcamp.com\/track\/(?<title>.+)/
        BandcampTrack
      when /(?<artist>.+)\.bandcamp.com\/album\/(?<title>.+)/
        BandcampAlbum
      end

      create! listable: listable_type.new, url: base_uri, list: list, artist: $1, title: $2
    end
  end
end

class UnparsableTrackUrlError < StandardError; end
