module ApplicationHelper
  def money(price)
    number_to_currency(price, delimiter: " ", precision: 0, unit: "€")
  end
end
