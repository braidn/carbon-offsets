require_relative 'spec_helper'

describe Offset do
  before :all do
    @offset = Offset.create({ mass_g: 100, price_cents_usd: 3000.0 })
  end

  describe '#retire!' do
    it 'retires the offset if the mass equates to the offset\'s total' do
      @offset.retire!(100)

      _(Offset[@offset.id][:retired]).must_equal true
    end
  end
end
