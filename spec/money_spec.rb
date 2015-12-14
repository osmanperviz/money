require 'spec_helper'

describe Money do
  it 'has a version number' do
    expect(Money::VERSION).not_to be nil
  end

  describe 'attributes' do
    let(:money){Money.new(50,'EUR')}

    it 'allows reading and writing for :currency' do
      expect(money.currency).to eq('EUR')
    end

    it 'allows reading and writing for :amaunt' do
      expect(money.amaunt).to eq(50)
    end

  end

  describe '.conversion_rates' do
     it 'allows to set coversion rates' do
       Money.conversion_rates('EUR',{'USD'=> 1.10,'Bitcoin'=> 0.0047})
       expect(Money.class_variable_get(:@@conversion_rates)).to eq({"EUR"=>{"USD"=>1.1, "Bitcoin"=>0.0047}})
     end
  end

  describe '#convert_to' do
    let(:money){Money.new(50,'EUR')}
    Money.conversion_rates('EUR',{'USD'=> 1.10,'Bitcoin'=> 0.0047})

    context 'when convert valid currency' do
      it 'allows convertion to another  currensy' do
        expect(money.convert_to('USD')).to be_an_instance_of(Money)
      end
    end
  end
end
