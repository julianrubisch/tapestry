class InboxController < ApplicationController
  def show
    @list_entry = ListEntry.new
    @list_entries = current_user.inbox.list_entries
  end
end
