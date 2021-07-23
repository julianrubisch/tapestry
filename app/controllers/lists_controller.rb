class ListsController < ApplicationController
  before_action :set_list, only: %i[show active_track]
  before_action :set_active_track, only: :show

  def show
    authenticate_user! unless @list.public
  end

  def active_track
    session["list_#{@list.id}"][:active] = Track.find(list_params[:active_track_id]).list_entry.to_gid.to_s

    render turbo_stream: turbo_stream.replace(@list)
  end

  private

  def list_params
    params.require(:list).permit(:active_track_id)
  end

  def set_list
    @list = List.friendly.find(params[:id])
  end

  def set_active_track
    session["list_#{@list.id}"] ||= {}
    session["list_#{@list.id}"][:active] ||= @list.list_entries.first.to_gid.to_s
  end
end
