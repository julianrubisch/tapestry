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
#  list_id       :uuid             not null
#  listable_id   :uuid
#
# Indexes
#
#  index_list_entries_on_list_id  (list_id)
#  index_list_entries_on_slug     (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (list_id => lists.id)
#

require "open-uri"

class ListEntry < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :list

  delegated_type :listable, types: %w[Track Playlist]

  validates :url, :title, :artist, presence: true

  broadcasts_to ->(list_entry) { :list_entries }, inserts_by: :append, target: "list_entries_inner"

  def self.init_from_url(url:, list:)
    return new(list: list) if url.blank?

    URI.open(url) do |uri|
      base_uri = uri.base_uri

      listable_type = case base_uri.to_s
      when /soundcloud.com\/(?<artist>.+)\/tracks/
        raise UnparsableTrackUrlError
      when /soundcloud.com\/(?<artist>.+)\/sets\/(?<title>.+)/
        SoundCloudPlaylist
      when /soundcloud.com\/(?<artist>.+)\/(?<title>.+)/
        SoundCloudTrack
      when /https?:\/\/(?<artist>.+)\.bandcamp.com\/track\/(?<title>.+)/
        BandcampTrack
      when /https?:\/\/(?<artist>.+)\.bandcamp.com\/album\/(?<title>.+)/
        BandcampAlbum
      end

      new listable: listable_type.new, url: base_uri, list: list, artist: $1, title: $2
    end
  end
end

class UnparsableTrackUrlError < StandardError; end
