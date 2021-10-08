class ListEntriesController < ApplicationController
  before_action :set_list, only: :show
  before_action :set_list_entry, only: %i[ show edit update destroy ]

  # GET /list_entries or /list_entries.json
  def index
    @list_entries = ListEntry.all
  end

  # GET /list_entries/1 or /list_entries/1.json
  def show
  end

  # GET /list_entries/new
  def new
    @list_entry = ListEntry.new
  end

  # GET /list_entries/1/edit
  def edit
  end

  # POST /list_entries or /list_entries.json
  def create
    @list_entry = ListEntry.init_from_url(url: list_entry_params[:url], list: current_user.inbox)

    respond_to do |format|
      if @list_entry.save
        format.html { redirect_to inbox_path, notice: "List entry was successfully created." }
      else
        @list_entries = current_user.inbox.list_entries
        format.html { render "inbox/show", status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /list_entries/1 or /list_entries/1.json
  def update
    respond_to do |format|
      if @list_entry.update(list_entry_params)
        format.html { redirect_to @list_entry, notice: "List entry was successfully updated." }
        format.json { render :show, status: :ok, location: @list_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_entries/1 or /list_entries/1.json
  def destroy
    @list_entry.destroy
    respond_to do |format|
      format.html { redirect_to list_entries_url, notice: "List entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_entry
      @list_entry = ListEntry.friendly.find(params[:id])
    end

    def set_list
      @list = List.friendly.find(params[:list_id])
      session[@list.to_gid.to_s] ||= {}
    end

    # Only allow a list of trusted parameters through.
    def list_entry_params
      params.require(:list_entry).permit(:title, :url, :artist)
    end
end
