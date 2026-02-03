class ListsController < ApplicationController
  # GET /lists
  def index
    @lists = List.all
  end

  # GET /list/new
  def new
    @list = List.new
  end

  # POST /list
  def create
    @list = List.new(list_params)
    @list.save
    redirect_to list_path(@list)
  end

  # GET /lists/:id
  def show
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
