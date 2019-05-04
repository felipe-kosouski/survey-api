class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :update, :destroy]

  def index
    @surveys = Survey.all
    render json: @surveys
  end

  def show
    if @survey
      render json: @survey
    else
      render json: @survey.errors, status: :not_found
    end
  end

  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      render json: @survey, status: :created
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  def update
    if @survey.update(survey_params)
      render json: @survey, status: :no_content
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @survey.destroy
  end

  private

  def survey_params
    params.permit(:title, :startDate, :endDate, :status)
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end
end
