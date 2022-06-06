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
      list.playables.sample
    elsif repeat && playable.first_for_list?(list)
      playable.last_for_list(list)
    else
      playable.previous_for_list(list)
    end
  end

  def next_playable
    if shuffle
      list.playables.sample
    elsif repeat && playable.last_for_list?(list)
      playable.first_for_list(list)
    else
      playable.next_for_list(list)
    end
  end

  def button_klass(active = false)
    "inline-flex items-center px-3.5 py-2 border border-transparent text-sm leading-4 font-medium shadow-sm #{active ? "text-primary-800" : "text-white" } #{active ? "bg-primary-50" : "bg-primary-800"} hover:bg-primary-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-700 disabled:opacity-50 #{active ? "border-primary-800" : "border-transparent"}"
  end
end
