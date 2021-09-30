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

require "open-uri"

class ListEntry < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :list_entry_list_items, -> { order(position: :asc) }
  has_many :lists, through: :list_entry_list_items

  delegated_type :listable, types: %w[Track Playlist]

  validates :url, :title, :artist, presence: true

  broadcasts_to ->(list_entry) { :list_entries }, inserts_by: :append, target: "list_entries_inner"

  def self.init_from_url(url:, list: nil)
    return new(lists: [list].compact) if url.blank?

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

      new listable: listable_type.new, url: base_uri, lists: [list].compact, artist: $1, title: $2
    end
  end

  def first_for_list?(list)
    list_entry_list_items.find_by(list_id: list.id).first?
  end

  def last_for_list?(list)
    list_entry_list_items.find_by(list_id: list.id).last?
  end

  def first_for_list(list)
    list.list_entry_list_items.first.list_entry
  end

  def last_for_list(list)
    list.list_entry_list_items.last.list_entry
  end

  def next_for_list(list)
    list_entry_list_items.find_by(list_id: list.id).lower_item&.list_entry
  end

  def previous_for_list(list)
    list_entry_list_items.find_by(list_id: list.id).higher_item&.list_entry
  end
end

class UnparsableTrackUrlError < StandardError; end
