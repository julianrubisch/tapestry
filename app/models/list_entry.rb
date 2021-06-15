# == Schema Information
#
# Table name: list_entries
#
#  id            :uuid             not null, primary key
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

  def self.create_from_url(url:, list:)
    URI.open(url) do |uri|
      base_uri = uri.base_uri

      case base_uri.to_s
      when /soundcloud.com\/(?<artist>.+)\/tracks/
        raise UnparsableTrackUrlError
      when /soundcloud.com\/(?<artist>.+)\/(?<track>.+)/
        create! listable: SoundCloudTrack.new, url: base_uri, list: list
      end
    end
  end
end

class UnparsableTrackUrlError < StandardError; end
