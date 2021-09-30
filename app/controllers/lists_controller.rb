class ListsController < ApplicationController
  before_action :set_list, only: %i[show active_track toggle_repeat toggle_shuffle]
  before_action :set_active_track, only: %i[show toggle_repeat toggle_shuffle]

  def show
    authenticate_user! unless @list.public
  end

  def active_track
    session[@list.to_gid.to_s][:active] = Track.find(list_params[:active_track_id]).list_entry.to_gid.to_s

    render turbo_stream: turbo_stream.replace(@list)
  end

  def toggle_repeat
    session[@list.to_gid.to_s][:repeat] = !session[@list.to_gid.to_s].fetch("repeat", false)

    render turbo_stream: turbo_stream.replace(@list)
  end

  def toggle_shuffle
    session[@list.to_gid.to_s][:shuffle] = !session[@list.to_gid.to_s].fetch("shuffle", false)

    render turbo_stream: turbo_stream.replace(@list)
  end

  private

  def list_params
    params.require(:list).permit(:active_track_id)
  end

  def set_list
    @list = List.friendly.find(params[:id])
    session[@list.to_gid.to_s] ||= {}
  end

  def set_active_track
    session[@list.to_gid.to_s][:active] ||= @list.list_entries.first.to_gid.to_s
  end
end
