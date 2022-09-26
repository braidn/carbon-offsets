class Offset < Sequel::Model
  def retire!(mass)
    return unless mass == mass_g
    update({ retired: true })
  end
end
