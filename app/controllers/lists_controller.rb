class ListsController < ApplicationController
  before_action :set_list, only: :show
  before_action :set_active_track, only: :show

  def show
    authenticate_user! unless @list.public
  end

  private

  def set_list
    @list = List.friendly.find(params[:id])
  end

  def set_active_track
    session["list_#{@list.id}"] ||= {}
    session["list_#{@list.id}"][:active] ||= @list.list_entries.first
  end
end
