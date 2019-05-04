require 'rails_helper'

RSpec.describe "Options API", type: :request do
  let!(:survey) { create(:survey) }
  let!(:options) { create_list(:option, 5, survey_id: survey.id) }
  let(:survey_id) { survey.id }
  let(:option_id) { options.first.id }

  describe 'GET /surveys/:survey_id/options' do
    before { get "/surveys/#{survey_id}/options" }

    context 'when survey exists' do
      it 'should return response status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return all survey options' do
        expect(json.size).to eq(5)
      end
    end

    context 'when survey does not exist' do
      let(:survey_id) { 0 }

      it 'should return response status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(response.body).to match(/Couldn't find Survey/)
      end
    end
  end

  describe 'GET /surveys/:survey_id/options/:option_id' do
    before { get "/surveys/#{survey_id}/options/#{option_id}" }

    context 'when survey option exists' do
      it 'should return response status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return the option' do
        expect(json['id']).to eq(option_id)
      end
    end

    context 'when survey option does not exist' do
      let(:option_id) { 0 }

      it 'should return response status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(response).to match(/Couldn't find Option/)
      end
    end
  end

  describe 'POST /surveys/:survey_id/options' do
    let(:option_params) do
      {
          title: "Option 1 for survey"
      }
    end

    context 'when the request if valid' do
      before { post "/surveys/#{survey_id}/options", params: option_params }

      it 'should return response status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/surveys/#{survey_id}/options", params: {} }

      it 'should return response status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'should return a failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /surveys/:survey_id/options/:option_id' do
    let(:option_params) do
      {
          title: "Modifying option 1"
      }
    end

    before { post "/surveys/#{survey_id}/options/#{option_id}", params: option_params }

    context 'when option exists' do
      it 'should return response status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'should update the option' do
        updated_option = Option.find(option_id)
        expect(updated_option.title).to match(/Modifying option 1/)
      end
    end

    context 'when the option does not exist' do
      let(:option_id) { 0 }

      it 'should return response status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(response.body).to match(/Coudn't find Option/)
      end
    end
  end

  describe 'DELETE /surveys/:survey_id/options/:option_id' do
    before { delete "/surveys/#{survey_id}/options/#{option_id}" }

    it 'should return response status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end