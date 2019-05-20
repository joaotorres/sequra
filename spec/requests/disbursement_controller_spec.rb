require "rails_helper"

RSpec.describe "Disbursement List API", :type => :request do

  let(:year) { 2018 }
  let(:week) { 1 }

  context "if there's no disbursements" do
    it "responds with 200 and an empty array" do
      get "/api/v1/disbursements", params: { year: year, week: week, format: :json }
      expect(response).to have_http_status(200)
      expect(response.body).to eq [].to_json
    end
  end

  context "if there are disbursements" do

    let(:merchant) { Merchant.create(name: 'Jon Snow', email: 'b@b.com', cif: '2345678901P') }
    let(:merchant2) { Merchant.create(name: 'Theon Greyjoy', email: 'c@b.com', cif: '3456789012P') }
    let!(:disbursement1) { Disbursement.create(year: 2018, week: 1, merchant: merchant, amount: 10.to_money) }
    let!(:disbursement2) { Disbursement.create(year: 2018, week: 1, merchant: merchant2, amount: 50.to_money) }

    context "if the merchant IS NOT provided in the params" do
      it "responds with 200 and all the appropriate disbursements" do
        get "/api/v1/disbursements", params: { year: year, week: week, format: :json }
        expect(response).to have_http_status(200)
        expect(response.body).to eq Disbursement.all.map { |d|  {
          merchant_id: d.merchant_id,
          amount: ActionController::Base.helpers.humanized_money(d.amount)}
        }.to_json
      end
    end

    context "if the merchant IS provided in the params" do
      it "responds with 200 and all the disbursements from the specified merchant" do
        get "/api/v1/disbursements", params: { year: year, week: week, merchant: merchant.id, format: :json }
        expect(response).to have_http_status(200)
        expect(response.body).to eq Disbursement.where(merchant: merchant).map { |d|  {
          merchant_id: d.merchant_id,
          amount: ActionController::Base.helpers.humanized_money(d.amount)}
        }.to_json
      end
    end
  end
end