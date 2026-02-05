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
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /lists/:id
  def show
    @list = List.find(params[:id])
    @review = Review.new
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
