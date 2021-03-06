# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe BoardsController do
  let(:json_response) { JSON.parse(response.body) }

  context 'POST #reset' do
    it 'resets the board and renders a new random board' do
      post :reset
      expect(response).to have_http_status(:ok)
      expect(json_response['board']).to be_a Array
    end
  end

  context 'GET #find' do
    let(:session) { { board: [%w[G O D S]] } }

    it 'finds a valid word and its score' do
      get :find, params: { word: 'Dog' }, session: session
      expect(response).to have_http_status(:ok)
      expect(json_response['word']).to  eq 'DOG'
      expect(json_response['score']).to eq 1
    end

    it 'complains about short words' do
      get :find, params: { word: 'x' }, session: session
      expect(json_response['error']).to eq '"X" is too short'
    end

    it 'complains about missing words' do
      get :find, params: { word: 'abc' }, session: session
      expect(json_response['error']).to eq '"ABC" is not on the board'
    end

    it 'complains about fake words' do
      get :find, params: { word: 'sdog' }, session: session
      expect(json_response['error']).to eq '"SDOG" is not a real word'
    end
  end
end
# rubocop:enable Metrics/BlockLength
