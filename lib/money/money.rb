class Money
  attr_accessor :currency,:amount

  def initialize(amount,currency )
    @amount = amount
    @currency = currency
  end

  def inspect
  "#{@amount} #{@currency}"
  end

  def self.conversion_rates(curensy,options={})
    self.class_variable_set(:@@conversion_rates,curensy=>options )
  end

  def convert_to(currency)
    raise ArgumentError,"Not allowed currency" if @@conversion_rates[@currency].nil? || @@conversion_rates[@currency][currency].nil?
    converted_value = (@amount * @@conversion_rates[@currency][currency]).round(1)
    self.class.new(converted_value,currency)
  end

  def + (another)
    check_currency?(another)
    self.class.new((@amount + another.amount),@currency)
  end

  def - (another)
    check_currency?(another)
    self.class.new((@amount - another.amount).abs,@currency)
  end

  def / (another)
    if another.instance_of? Money
      check_currency?(another)
    end
    sum = another.is_a?(Money) ? (@amount / another.amount).round(2) : (@amount / another).round(2)
    self.class.new(sum,@currency)
  end

  def == (another)
    check_currency?(another)
    another.amount.ceil == @amount.ceil
  end

  def > (another)
    check_currency?(another)
    __method__.to_s == '>' ? @amount > another.amount : @amount < another.amount
  end

  def < (another)
    check_currency?(another)
    __method__.to_s == '<' ? @amount < another.amount : @amount > another.amount
  end

  private

  def check_currency?(another)
    unless @currency == another.currency
      if @@conversion_rates.keys.include? @currency
        another.amount = (another.amount / @@conversion_rates[@currency][another.currency]).round(2)
      else
        another.amount = (another.amount * @@conversion_rates[another.currency][@currency]).round(2)
      end
    end
  end

end