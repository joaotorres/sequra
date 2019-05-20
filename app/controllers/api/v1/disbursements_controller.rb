class Api::V1::DisbursementsController < Api::V1::BaseController
  def index
    if params[:merchant]
      @disbursements = Disbursement.where(year: params[:year], week: params[:week], merchant_id: params[:merchant])
    else
      @disbursements = Disbursement.where(year: params[:year], week: params[:week])
    end
  end
end