class Activity
  attr_reader :date, :title, :miles, :calories_burned, :gas_money_saved, :beers_banked

  def initialize(data)
    @date = convert_date(data[:date])
    @title = data[:title]
    @miles = data[:miles]
    @calories_burned = data[:calories_burned]
    @gas_money_saved = data[:gas_money_saved]
    @beers_banked = data[:beers_banked]
  end

  def convert_date(date)
    y = date[0..4].to_i
    m = date[5..6].to_i
    d = date[8..9].to_i
    DateTime.new(y, m, d)
  end
end