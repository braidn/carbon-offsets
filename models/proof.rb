class Proof < Sequel::Model
  def validate
    super

    errors.add(:mass_g, mass_outweighed_error_msg) if mass_outweighs_offset?
  end

  def after_create
    capture_payments
    offset.retire!(mass_g)

    super
  end

  private

  def offset
    @offset ||= Offset[offset_id]
  end

  def mass_outweighs_offset?
    return true if mass_g > offset[:mass_g]
    false
  end

  def mass_outweighed_error_msg
    'Cannot exceed Offset mass:Reassess mass required for Proof and pass a value less than or equal to the Offset mass'
  end

  def capture_payments
    orders = Order.where(offset_id: offset_id, captured: false)
    orders.each { |order| order.capture! }
  end
end
