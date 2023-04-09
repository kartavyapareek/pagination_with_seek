require 'rails_helper'

RSpec.describe "Employees", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:employee, 450)
    end

    context "without params" do
      before do
        get '/employees'
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'retrun json with 2 attributes' do
        expect(JSON.parse(body).size).to eq(2)
      end

      it 'returns 100 records' do
        expect(JSON.parse(body).dig('data').size).to eq(100)
      end

      it 'return first page with prev_page_id as nil' do
        expect(JSON.parse(body).dig('cursor', 'prev_page_id')).to eq(nil)
      end

      it 'return latest record first' do
        expect(JSON.parse(body).dig('data')[0]['id']).to eq(450)
      end
    end

    context "with next_page_id as params" do
      let(:params) { { 'next_page_id' => Employee.find(351).identification_number } }

      before do
        get '/employees', params: params
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'retrun json with 2 attributes' do
        expect(JSON.parse(body).size).to eq(2)
      end

      it 'returns 100 records' do
        expect(JSON.parse(body).dig('data').size).to eq(100)
      end

      it 'return first record with id eq 350' do
        expect(JSON.parse(body).dig('data')[0]['id']).to eq(350)
      end

      it 'return first record with identification_number of record with if 350' do
        expect(JSON.parse(body).dig('data')[0]['identification_number']).to eq(Employee.find(350).identification_number)
      end
    end

    context "with prev_page_id as params" do
      let(:params) { { 'prev_page_id' => Employee.find(250).identification_number } }

      before do
        get '/employees', params: params
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'retrun json with 2 attributes' do
        expect(JSON.parse(body).size).to eq(2)
      end

      it 'returns 100 records' do
        expect(JSON.parse(body).dig('data').size).to eq(100)
      end

      it 'return first record with id eq 350' do
        expect(JSON.parse(body).dig('data')[0]['id']).to eq(350)
      end

      it 'return first record with identification_number of record with if 350' do
        expect(JSON.parse(body).dig('data')[0]['identification_number']).to eq(Employee.find(350).identification_number)
      end
    end


    context "with page_number as params" do
      let(:params) { { 'page_number' => 4 } }

      before do
        get '/employees', params: params
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'retrun json with 2 attributes' do
        expect(JSON.parse(body).size).to eq(2)
      end

      it 'returns 100 records' do
        expect(JSON.parse(body).dig('data').size).to eq(100)
      end

      it 'return first record with id eq 150' do
        expect(JSON.parse(body).dig('data')[0]['id']).to eq(150)
      end

      it 'return first record with identification_number of record with if 150' do
        expect(JSON.parse(body).dig('data')[0]['identification_number']).to eq(Employee.find(150).identification_number)
      end
    end

    context "response for last page" do
      let(:params) { { 'page_number' => 5 } }

      before do
        get '/employees', params: params
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'retrun json with 2 attributes' do
        expect(JSON.parse(body).size).to eq(2)
      end

      it 'returns 100 records' do
        expect(JSON.parse(body).dig('data').size).to eq(50)
      end

      it 'return first record with id eq 50' do
        expect(JSON.parse(body).dig('data')[0]['id']).to eq(50)
      end

      it 'return first record with identification_number of record with if 50' do
        expect(JSON.parse(body).dig('data')[0]['identification_number']).to eq(Employee.find(50).identification_number)
      end

      it 'return first page with next_page_id as nil' do
        expect(JSON.parse(body).dig('cursor', 'next_page_id')).to eq(nil)
      end
    end
  end
end
