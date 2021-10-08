# frozen_string_literal: true

class PlayerComponent < ViewComponent::Base
  attr_reader :playable, :list, :repeat, :shuffle

  def initialize(playable:, list:, repeat:, shuffle:)
    @list = list
    @playable = playable
    @repeat = repeat
    @shuffle = shuffle
  end

  def previous_playable
    if shuffle
      list.list_entries.sample
    elsif repeat && playable.first_for_list?(list)
      playable.last_for_list(list)
    else
      playable.previous_for_list(list)
    end
  end

  def next_playable
    if shuffle
      list.list_entries.sample
    elsif repeat && playable.last_for_list?(list)
      playable.first_for_list(list)
    else
      playable.next_for_list(list)
    end
  end

  def button_klass(active = false)
    "inline-flex items-center px-3.5 py-2 border border-transparent text-sm leading-4 font-medium rounded-full shadow-sm text-white #{active ? "bg-amber-700" : "bg-amber-500"} hover:bg-amber-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500 disabled:opacity-50"
  end
end
