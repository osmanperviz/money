class Money
  attr_accessor :currency,:amaunt

  def initialize(amaunt,currency )
    @amaunt = amaunt
    @currency = currency
  end

  def self.conversion_rates(curensy,options={})
    self.class_variable_set(:@@conversion_rates,curensy=>options )
  end

end