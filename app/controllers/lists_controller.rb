class ListsController < ApplicationController
  before_action :set_list, only: :show
  before_action :set_active_track, only: :show

  def show
    authenticate_user! unless @list.public
  end

  def active_track
  end

  private

  def active_track_params
    params.require(:list).permit(:active_track_id)
  end

  def set_list
    @list = List.friendly.find(params[:id])
  end

  def set_active_track
    session["list_#{@list.id}"] ||= {}
    session["list_#{@list.id}"][:active] ||= @list.list_entries.first
  end
end
