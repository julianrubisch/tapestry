class ListsController < ApplicationController
  before_action :set_list, only: %i[show active_playable toggle_repeat toggle_shuffle]
  before_action :set_active_playable, only: %i[show toggle_repeat toggle_shuffle]

  def show
    authenticate_user! unless @list.public
  end

  def active_playable
    @list.active_playables[current_user.id] = Playable.find(list_params[:active_playable_id]).to_gid.to_s

    # TODO make this a .turbo_stream.erb partial
    render turbo_stream: turbo_stream.replace(@list, partial: "lists/list", locals: {list: @list, user: current_user})
  end

  def toggle_repeat
    session[@list.to_gid.to_s][:repeat] = !session[@list.to_gid.to_s].fetch("repeat", false)

    render turbo_stream: turbo_stream.replace(@list, partial: "lists/list", locals: {list: @list, user: current_user})
  end

  def toggle_shuffle
    session[@list.to_gid.to_s][:shuffle] = !session[@list.to_gid.to_s].fetch("shuffle", false)

    render turbo_stream: turbo_stream.replace(@list, partial: "lists/list", locals: {list: @list, user: current_user})
  end

  private

  def list_params
    params.require(:list).permit(:active_playable_id)
  end

  def set_list
    @list = List.friendly.find(params[:id])
    session[@list.to_gid.to_s] ||= {}
  end

  def set_active_playable
    @list.active_playables[current_user.id] ||= @list.playables.first.to_gid.to_s
  end
end
