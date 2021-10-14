class BandcampTrackScraperJob < ApplicationJob
  queue_as :default

  def perform(track)
    # 1. open track.url with faraday
    body = Faraday.get(track.playable.url).body

    # 2. scrape with nokogiri for <script type="application/ld+json">
    doc = Nokogiri::HTML(body)
    cdata = doc.css("script[type='application/ld+json']").children.first.to_s.strip

    # 3. parse innerText as json
    meta = JSON.parse(cdata)

    # 4. store in meta JSONB
    track.update(meta: meta)

    # 5. and store properties
    track.playable.update(artist: track.byArtist["name"], title: track.name)
    # track.update(audio_url: track.additionalProperty.find { |entry| entry["name"] == "file_mp3-128" }["value"])
  end
end
