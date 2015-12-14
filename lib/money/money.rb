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

  def + (anOther)
    check_currency?(anOther)
    self.class.new((@amount + anOther.amount),@currency)
  end

  def - (anOther)
    check_currency?(anOther)
    self.class.new((@amount - anOther.amount).abs,@currency)
  end

  def / (anOther)
    if anOther.instance_of? Money
      check_currency?(anOther)
    end
    sum = anOther.is_a?(Money) ? (@amount / anOther.amount).round(2) : (@amount / anOther).round(2)
    self.class.new(sum,@currency)
  end


  private

  def check_currency?(anOther)
    unless @currency == anOther.currency
      if @@conversion_rates.keys.include? @currency
        anOther.amount = (anOther.amount / @@conversion_rates[@currency][anOther.currency]).round(2)
      else
        anOther.amount = (anOther.amount * @@conversion_rates[anOther.currency][@currency]).round(2)
      end
    end
  end

end