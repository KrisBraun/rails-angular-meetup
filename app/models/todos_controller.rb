class TodosController < ApplicationController
  respond_to :json

  def index
    @todos = Todo.all
  end
  def create
    @todo = Todo.new(params[:todo])
    if @todo.save
      render action: :show, status: :created
    else
      render json: @todo.andand.errors, status: :unprocessable_entity
    end
  end
  def update
    @todo = Todo.find(params[:id])
    if @todo.update_attributes(params[:todo])
      render action: :show
    else
      render json: @todo.andand.errors, status: :unprocessable_entity
    end
  end
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    head :no_content
  end
end
