class PlayablesController < ApplicationController
  before_action :set_list, only: :show
  before_action :set_playable, only: %i[ show edit update destroy ]

  # GET /playables or /playables.json
  def index
    @playables = Playable.all
  end

  # GET /playables/1 or /playables/1.json
  def show
  end

  # GET /playables/new
  def new
    @playable = Playable.new
  end

  # GET /playables/1/edit
  def edit
  end

  # POST /playables or /playables.json
  def create
    @playable = Playable.init_from_url(url: playable_params[:url], list: current_user.inbox)

    respond_to do |format|
      if @playable.save
        format.html { redirect_to inbox_path, notice: "List entry was successfully created." }
      else
        @playables = current_user.inbox.playables
        format.html { render "inbox/show", status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playables/1 or /playables/1.json
  def update
    respond_to do |format|
      if @playable.update(playable_params)
        format.html { redirect_to @playable, notice: "List entry was successfully updated." }
        format.json { render :show, status: :ok, location: @playable }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @playable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playables/1 or /playables/1.json
  def destroy
    @playable.destroy
    respond_to do |format|
      format.html { redirect_to playables_url, notice: "List entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playable
      @playable = Playable.friendly.find(params[:id])
    end

    def set_list
      @list = List.friendly.find(params[:list_id])
      session[@list.to_gid.to_s] ||= {}
    end

    # Only allow a list of trusted parameters through.
    def playable_params
      params.require(:playable).permit(:title, :url, :artist)
    end
end
