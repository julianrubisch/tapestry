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
end
