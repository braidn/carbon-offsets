require_relative 'spec_helper'

describe Proof do
  before :all do
    @offset = Offset.create({ mass_g: 100000, price_cents_usd: 3000.0 })
  end

  describe 'validations' do
    it 'fails validation checks if the mass is more than the offset' do
      proof = Proof.new({ mass_g: 200000, serial_number: '123MEPLS', offset_id: @offset.id })
      proof.valid?
      
      _(proof.errors[:mass]).must_include('cannot exceed Offset mass')
    end
  end
end
