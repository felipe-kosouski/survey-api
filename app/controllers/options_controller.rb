class OptionsController < ApplicationController
  before_action :set_survey
  before_action :set_survey_option, only: [:show, :update, :destroy]

  def index
    @options = @survey.options
    render json: @options, status: :ok
  end

  def show
    render json: @option
  end

  def new
    @option = @survey.options.new
  end

  def create
    @option = @survey.options.new(option_params)

    if @option.save
      render json: @option, status: :created
    else
      render json: @option.errors, status: :unprocessable_entity
    end
  end

  def update
    if @option.update(option_params)
      render json: @option, status: :ok
    else
      render json: @option.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @option.destroy
  end

  private

  def option_params
    params.permit(:title)
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_survey_option
    @option = @survey.options.find_by(id: params[:id]) if @survey
  end
end
