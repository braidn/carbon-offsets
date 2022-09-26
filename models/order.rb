class Order < Sequel::Model
  def capture!
    update({ captured: true })
  end
end
