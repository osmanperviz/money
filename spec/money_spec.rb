require 'spec_helper'

describe Money do

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
       expect(Money.conversion_rate).to eq({"EUR"=>{"USD"=>1.11, "Bitcoin"=>0.0047}})
     end
  end

  describe '#convert_to' do
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

      context 'when you count two different currencies (EUR - DOLAR)' do
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
    context 'when subtract the same two currencies' do
      it 'return new Money instance' do
        expect(money - another_eur).to  be_an_instance_of(Money)
      end
      it 'return correct currency' do
        expect((money - another_eur).currency).to eq('EUR')
      end
      it 'return correct amaunt' do
        expect((money - another_eur).amount).to eq(30)
      end
    end

    context 'when subtract two different currencies(DOLAR - EUR)' do
      it 'return new Money instance' do
        expect(dolar - money).to  be_an_instance_of(Money)
      end
      it 'return correct currency' do
        expect((dolar - money).currency).to eq('USD')
      end
      it 'return correct amaunt' do
        expect((dolar - money).amount).to eq(-35.5)
      end
    end

    context 'when subtract smaller amaunt from a larger amaunt same currency' do
      it 'return new Money instance' do
        expect(another_eur - money).to  be_an_instance_of(Money)
      end
      it 'return correct currency' do
        expect((another_eur - money).currency).to eq('EUR')
      end
      it 'return correct amaunt' do
        expect((another_eur - money).amount).to eq(-30)
      end
    end
  end

  describe '#/' do
    context 'when devide with ordinary number' do
      it 'return new Money instance' do
        expect(money / 2).to  be_an_instance_of(Money)
      end
      it 'return correct currency' do
        expect((money / 2).currency).to eq('EUR')
      end
      it 'return correct amaunt' do
        expect((money / 3 ).amount).to eq(16.0)
      end
    end

    context 'when devide with the same currency' do
      it 'return new Money instance' do
        expect(money / another_eur).to  be_an_instance_of(Money)
      end
      it 'return correct currency' do
        expect((money / another_eur).currency).to eq('EUR')
      end
      it 'return correct amaunt' do
        expect((money / another_eur).amount).to eq(2.0)
      end
    end

    context 'when devide with different currency' do
      it 'return new Money instance' do
        expect(money / dolar).to  be_an_instance_of(Money)
      end
      it 'return correct currency' do
        expect((money / dolar).currency).to eq('EUR')
      end
      it 'return correct amaunt' do
        expect((money / dolar).amount).to eq(2.77)
      end
    end

  end

  describe '#=' do
    context 'when checking the equality of the same two currencies' do
      it 'return false on unequal currency' do
        expect(money == Money.new(52,'EUR')).to  be_falsey
      end
      it 'return true on equal currency' do
        expect(money == Money.new(50,'EUR')).to  be_truthy
      end
    end

    context 'when checking the equality of different currencies' do
      it 'return false on unequal currency' do
        expect(money == dolar).to  be_falsey
      end
      it 'return true on equal currency' do
        expect(money == Money.new(55.5,'USD')).to  be_truthy
      end
    end
  end

  describe '#>' do
    context 'When checking the value of a currency versus other values same currency' do
      it 'returns true if compared with the second value is greater' do
        expect(money > Money.new(49,'EUR')).to  be_truthy
      end
      it 'returns false if compared with the second value is smaller' do
        expect(money > Money.new(55,'EUR')).to  be_falsey
      end
    end

    context 'When checking the value of a currency versus other values different currency' do
      it 'returns true if compared with the second value is greater' do
        expect(money > Money.new(20,'USD')).to  be_truthy
      end
      it 'returns false if compared with the second value is smaller' do
        expect(money > Money.new(57,'USD')).to  be_falsey
      end
    end
  end

  describe '#<' do
    context 'When checking the value of a currency versus other values same currency' do
      it 'returns true if compared with the second value is smaller' do
        expect(money < Money.new(55,'EUR')).to  be_truthy
      end
      it 'returns false if compared with the second value is greater' do
        expect(money < Money.new(49,'EUR')).to  be_falsey
      end
    end

    context 'When checking the value of a currency versus other values different currency' do
      it 'returns true if compared with the second value is smaller' do
        expect(money < Money.new(69,'USD')).to  be_truthy
      end
      it 'returns false if compared with the second value is greater' do
        expect(money < Money.new(49,'USD')).to  be_falsey
      end
    end
  end


end
