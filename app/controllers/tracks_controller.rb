class TracksController < ApplicationController
  before_action :set_track, only: :show

  def show
    authenticate_user! unless @track.list.public
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    def set_list
      @list = List.friendly.find(params[:list_id])
      session[@list.to_gid.to_s] ||= {}
    end
end
