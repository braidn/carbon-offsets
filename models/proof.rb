class Proof < Sequel::Model
  def validate
    super

    errors.add(:mass_g, mass_outweighed_error_msg) if mass_outweighs_offset?
  end


  private

  def mass_outweighs_offset?
    offset = Offset.select(:mass_g)[offset_id]

    return true if mass_g > offset[:mass_g]
    false
  end

  def mass_outweighed_error_msg
    'Cannot exceed Offset mass:Reassess mass required for Proof and pass a value less than or equal to the Offset mass'
  end
end
