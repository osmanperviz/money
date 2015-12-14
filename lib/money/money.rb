class Money
  attr_accessor :currency,:amaunt

  def initialize(amaunt,currency )
    @amaunt = amaunt
    @currency = currency
  end

  def self.conversion_rates(curensy,options={})
    self.class_variable_set(:@@conversion_rates,curensy=>options )
  end

  def convert_to(currency)
    raise ArgumentError,"Not allowed currency" if @@conversion_rates[@currency].nil? || @@conversion_rates[@currency][currency].nil?
    converted_value = (@amaunt * @@conversion_rates[@currency][currency]).round(1)
    self.class.new(converted_value,currency)
  end

end