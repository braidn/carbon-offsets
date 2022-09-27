require_relative 'spec_helper'

describe Proof do
  let(:default_mass) { 100000 }
  before :all do
    @offset = Offset.create({ mass_g: default_mass, price_cents_usd: 3000.0 })
  end

  describe 'validations' do
    it 'fails validation checks if the mass is more than the offset' do
      proof = Proof.new({ mass_g: 200000, serial_number: '123MEPLS', offset_id: @offset.id })
      proof.valid?
      
      _(proof.errors[:mass_g]).must_include(
        'Cannot exceed Offset mass:Reassess mass required for Proof and pass a value less than or equal to the Offset mass'
      )
    end
  end

  describe 'callbacks' do
    it 'captures current payments/orders' do
      payment = Order.create({ offset_id: @offset.id, mass_g: 40000 } )
      proof = Proof.create({ mass_g: default_mass, serial_number: '123MEPLS', offset_id: @offset.id })

      _(Order.select(:captured)[payment.id].values[:captured]).must_equal true
    end

    it 'retires an offset where all the mass is consumed' do
      proof = Proof.create({ mass_g: default_mass, serial_number: '123MEPLS', offset_id: @offset.id })

      _(Offset.select(:retired)[@offset.id].values[:retired]).must_equal true
    end
  end
end
