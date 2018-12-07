module ApplicationHelper
  def money(price, args = { currency_symbol: true })
    if :currency_symbol == true
      number_with_delimiter(price.round, precision: 0, delimiter: " ")
    else
      number_to_currency(price, delimiter: " ", precision: 0, unit: "€")
    end
  end
end
