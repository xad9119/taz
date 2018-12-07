module ApplicationHelper
  def format_number(price, currency_symbol: true)
    if currency_symbol
      number_to_currency(price, delimiter: " ", precision: 0, unit: "€")
    else
      number_with_delimiter(price.round, precision: 0, delimiter: " ")
    end
  end
end
