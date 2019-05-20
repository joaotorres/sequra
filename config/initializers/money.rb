MoneyRails.configure do |config|
  Money.locale_backend = nil
  config.default_currency = :eur
end