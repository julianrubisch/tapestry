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
class BandcampTrack < Track
  after_create_commit :scrape_url

  store :meta, accessors: [:name, :image, :keywords, :duration, :byArtist, :additionalProperty]

  def scrape_url
    BandcampTrackScraperJob.perform_later self
  end
end
