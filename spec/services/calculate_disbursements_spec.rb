require 'rails_helper'

RSpec.describe CalculateDisbursements do
  describe '#call' do

    subject { described_class.new(year, week).call }

    let(:year) { 2018 }
    let(:week) { 1 }
    let(:shopper) { Shopper.create(name: 'Bran Stark', email: 'a@b.com', nif: '1234567890Q') }
    let(:merchant) { Merchant.create(name: 'Jon Snow', email: 'b@b.com', cif: '2345678901P') }

    context "if there's no orders" do
      it "creates no disbursements" do
        subject
        expect(Disbursement.count).to eq 0
      end
    end

    context "if there are orders" do
      it "creates appropriate disbursements" do
        Order.create(shopper: shopper, merchant: merchant, amount: 10.to_money, completed_at: DateTime.new(2018, 1, 1, 10, 0, 0))
        Order.create(shopper: shopper, merchant: merchant, amount: 10.to_money, completed_at: DateTime.new(2017, 1, 1, 10, 0, 0))

        subject
        expect(Disbursement.count).to eq 1
        expect(Disbursement.first.amount).to eq 10.to_money - (10.to_money * CalculateDisbursements::FEE_LESS_THAN_50)
      end

      context "and there's more than one merchant with orders with different amounts" do
        let(:merchant2) { Merchant.create(name: 'Theon Greyjoy', email: 'c@b.com', cif: '3456789012P') }

        it "calculates the right fee according to order amount" do
          Order.create(shopper: shopper, merchant: merchant, amount: 10.to_money, completed_at: DateTime.new(2018, 1, 1, 10, 0, 0))
          Order.create(shopper: shopper, merchant: merchant, amount: 100.to_money, completed_at: DateTime.new(2018, 1, 1, 10, 0, 0))
          Order.create(shopper: shopper, merchant: merchant, amount: 10.to_money, completed_at: DateTime.new(2018, 1, 8, 10, 0, 0))

          Order.create(shopper: shopper, merchant: merchant2, amount: 500.to_money, completed_at: DateTime.new(2018, 1, 1, 10, 0, 0))
          Order.create(shopper: shopper, merchant: merchant2, amount: 400.to_money, completed_at: DateTime.new(2017, 12, 1, 10, 0, 0))

          subject
          expect(Disbursement.count).to eq 2

          disbursement1 = Disbursement.where(merchant: merchant).first
          disbursement1_amount = (10.to_money - (10.to_money * CalculateDisbursements::FEE_LESS_THAN_50)) +
            (100.to_money - (100.to_money * CalculateDisbursements::FEE_BETWEEN_50_300))
          expect(disbursement1.amount).to eq disbursement1_amount

          disbursement2 = Disbursement.where(merchant: merchant2).first
          expect(disbursement2.amount).to eq (500.to_money - (500.to_money * CalculateDisbursements::FEE_MORE_THAN_300))
        end
      end
    end
  end
end