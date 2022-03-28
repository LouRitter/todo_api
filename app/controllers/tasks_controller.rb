class TasksController < ApplicationController
  before_action :authorize_request
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @tasks = Task.filter(filtering_(params))
    render json: @tasks, status: 200
  end

  def show
    @task = @current_user.tasks.find(params[:id])
    render json: @task
  end

  def create
    @task = Task.new(task_params)
    @current_user.tasks << @task
    if @task.save
      render json: @task
    else
      render json: @task.errors, status: 422
    end
  end

  def update
    @task = @current_user.tasks.find(params[:id])

    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors
    end
  end

  def destroy
    @task = @current_user.tasks.find(params[:id])
    if @task.destroy
      render json: { message: 'task deleted' }
    else
      render json: { errors: @task.errors }
    end
  end

  def not_found
    render json: {"error": "not_found"}, status: :not_found
  end

  private 

  def task_params
    params.permit(:title, :completed, :notes)
  end

  def filtering_(params)
    params.slice(:title, :start_date, :end_date, :completed)
  end


end
