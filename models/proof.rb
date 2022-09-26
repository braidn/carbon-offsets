class Proof < Sequel::Model
  def validate
    super

    errors.add(:mass, 'cannot exceed Offset mass') if mass_outweighs_offset?
  end


  private

  def mass_outweighs_offset?
    offset = Offset.select(:mass_g)[offset_id]

    return true if mass_g > offset[:mass_g]
    false
  end
end
