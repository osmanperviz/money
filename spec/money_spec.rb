require 'spec_helper'

describe Money do
  it 'has a version number' do
    expect(Money::VERSION).not_to be nil
  end

  let(:money){Money.new(50,'EUR')}
  let(:dolar){Money.new(20,'USD')}
  let(:another_eur){Money.new(20,'EUR')}
  describe 'attributes' do

    it 'allows reading and writing for :currency' do
      expect(money.currency).to eq('EUR')
    end

    it 'allows reading and writing for :amaunt' do
      expect(money.amount).to eq(50)
    end

  end

  describe '.conversion_rates' do
     it 'allows to set coversion rates' do
       Money.conversion_rates('EUR',{'USD'=> 1.11,'Bitcoin'=> 0.0047})
       expect(Money.class_variable_get(:@@conversion_rates)).to eq({"EUR"=>{"USD"=>1.11, "Bitcoin"=>0.0047}})
     end
  end

  describe '#convert_to' do
    Money.conversion_rates('EUR',{'USD'=> 1.10,'Bitcoin'=> 0.0047})
    # let(:money){Money.new(50,'EUR')}

    context 'when convert to valid currency' do
      it 'allows convertion to another  currency' do
        expect(money.convert_to('USD')).to be_an_instance_of(Money)
      end
      it 'return converted currency' do
        expect(money.convert_to('USD').currency).to eq('USD')
      end
      it 'return converted amaunt' do
        expect(money.convert_to('USD').amount).to eq(55.5)
      end

    end

    context 'when convert to invalid currency' do
      it 'raise ArgumentError if currency not valid' do
        expect{money.convert_to('usa')}.to raise_error(ArgumentError, 'Not allowed currency')
      end
    end
  end

  describe '#inspect' do
    it 'return amaunt + curency string' do
      expect(money.inspect).to eq('50 EUR')
    end
  end

  describe '#+' do
     context 'When calculate the same two currencies' do
        it 'return new Money instance' do
          expect(money + another_eur).to  be_an_instance_of(Money)
        end
        it 'return correct currency' do
          expect((money + another_eur).currency).to eq('EUR')
        end
        it 'return correct amaunt' do
          expect((money + another_eur).amount).to eq(70)
        end
     end

      context 'when you count two different currencies' do
        it 'return new Money instance' do
          expect(money + dolar).to  be_an_instance_of(Money)
        end
        it 'return correct currency' do
          expect((money + dolar).currency).to eq('EUR')
        end
        it 'return correct amaunt' do
          expect((money + dolar).amount).to eq(68.02)
        end
      end

  end
  describe '#-' do

  end

end
