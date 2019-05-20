class CalculateDisbursementsJob < ApplicationJob

  def perform(year, week)
    CalculateDisbursements.new(year, week).call
  end
end