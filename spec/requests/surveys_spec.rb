require 'rails_helper'

RSpec.describe "Surveys API", type: :request do
  let!(:surveys) { create_list(:survey, 10) }
  let(:survey_id) { surveys.first.id }
  let(:option) { create_list(:option, 3) }

  describe 'GET /surveys' do
    before { get '/surveys' }

    it 'should return surveys' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'should return response status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /surveys/:id' do
    before { get "/surveys/#{survey_id}" }

    context 'when the survey exists' do
      it 'should return the survey' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(survey_id)
      end

      it 'should return response status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the survey does not exist' do
      let(:survey_id) { 1000 }

      it 'should return response status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(json['error']).to match('Not Found')
      end
    end
  end

  describe 'POST /surveys' do
    let(:survey_params) do
      {
          title: "Is this a survey?",
          startDate: Date.today,
          endDate: Date.tomorrow,
          status: 0
      }
    end

    context 'when the request is valid' do
      before { post '/surveys', params: survey_params }

      it 'should create a survey' do
        expect(json['title']).to eq("Is this a survey?")
        expect(json['startDate']).to eq(Date.today.to_s)
        expect(json['endDate']).to eq(Date.tomorrow.to_s)
        expect(json['status']).to eq(0)
      end

      it 'should return response status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/surveys', params: { title: 'Just one option' } }

      it 'should return response status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'should return a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /surveys/:id' do
    let(:survey_params) { { title: 'Just want to alter this option' } }

    before { put "/surveys/#{survey_id}", params: survey_params }

    it 'should update the record' do
      expect(response.body).to be_empty
    end

    it 'should return response status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  describe 'DELETE /surveys/:id' do
    before { delete "/surveys/#{survey_id}" }

    it 'should return response status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end