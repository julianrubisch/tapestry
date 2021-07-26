# frozen_string_literal: true

class PlayerComponent < ViewComponent::Base
  attr_reader :track, :repeat, :shuffle

  def initialize(track:, repeat:, shuffle:)
    @track = track
    @repeat = repeat
    @shuffle = shuffle
  end

  def previous_track
    if repeat && track.list_entry.first?
      track.list.list_entries.last
    else
      track.list_entry.higher_item
    end
  end

  def next_track
    if repeat && track.list_entry.last?
      track.list.list_entries.first
    else
      track.list_entry.lower_item
    end
  end

  def button_klass(active = false)
    "inline-flex items-center px-3.5 py-2 border border-transparent text-sm leading-4 font-medium rounded-full shadow-sm text-white #{active ? "bg-amber-700" : "bg-amber-500"} hover:bg-amber-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500 disabled:opacity-50"
  end
end
