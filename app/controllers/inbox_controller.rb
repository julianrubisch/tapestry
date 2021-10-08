class InboxController < ApplicationController
  def show
    @playable = Playable.new
    @playables = current_user.inbox.playables
  end
end
