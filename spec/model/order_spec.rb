require_relative 'spec_helper'

describe Order do
  before :all do
    @offset = Offset.create({ mass_g: 100, price_cents_usd: 3000.0 })
  end

  describe '#capture!' do
    it 'sets the captured flag to true' do
      order = Order.create({ offset_id: @offset.id, mass_g: 40000 } )
      order.capture!

      _(Order[order.id][:captured]).must_equal true
    end
  end
end
