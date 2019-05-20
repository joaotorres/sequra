class CalculateDisbursements

  FEE_LESS_THAN_50 = 0.01
  FEE_BETWEEN_50_300 = 0.095
  FEE_MORE_THAN_300 = 0.085

  def initialize(year, week_number)
    @year = year
    @week_number = week_number
  end

  def call
    orders_by_merchant.each do |index, orders|
      total = 0.to_money

      orders.each do |order|
        total += (order.amount - fee_per_order(order))
      end

      Disbursement.create!(merchant_id: index, amount: total, year: @year, week: @week_number)
    end
  end

  private

  def orders_by_merchant
    @orders_by_merchant ||= Order.where(completed_at: week_start..week_end).group_by(&:merchant_id)
  end

  def week_start
    @week_start ||= Date.commercial(@year, @week_number, 1).beginning_of_day
  end

  def week_end
    @week_end ||= Date.commercial(@year, @week_number, 7).end_of_day
  end

  def fee_per_order(order)
    if order.amount < 50.to_money
      order.amount * FEE_LESS_THAN_50
    elsif order.amount < 300.to_money
      order.amount * FEE_BETWEEN_50_300
    else
      order.amount * FEE_MORE_THAN_300
    end
  end
end