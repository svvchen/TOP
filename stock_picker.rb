def picker(stock_prices)
  margin = 0
  buy_index = 0
  sell_index = 0

  stock_prices.each_with_index do |price, index|
    stock_max = stock_prices.max
    instance_margin = stock_max - price
    # puts stock_max
    # puts instance_margin

    if instance_margin > margin
      margin = instance_margin
      buy_index = index
      sell_index = stock_prices.index(stock_max)
      # puts margin
      # puts buy_index
      # puts sell_index
    end

    stock_prices[index] = 0

  end

  buy_day = buy_index + 1
  sell_day = sell_index + 1

  if buy_day == 1 && sell_day == 1
    return "Just keeps going down. No way to gain money :(."
  end

  return "To make $#{margin}, buy on day #{buy_day} and sell on day #{sell_day}!"
end

# in order to test:
# 1. Run irb.
# 2. Require './stock_picker.rb'.
# 3. Run picker([your array])!
