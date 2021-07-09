class ListsController < ApplicationController
  def show
    @list = List.friendly.find(params[:id])

    authenticate_user! unless @list.public
  end
end
