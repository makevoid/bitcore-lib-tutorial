
class NullAddress; end
class NullAmount; end

class Transaction

  def initialize
    @utxos = []
    @address  = NullAddress.new
    @amount   = NullAmount.new
    @change   = NullAmount.new
    @fee      = NullAmount.new
  end

  def serialize
    # ...
  end

  def from(utxos)
    @utxos = utxos
    self
  end

  def to(address, amount)
    @address = address
    @amount  = amount
    self
  end

  def change(amount)
    @change = amount
    self
  end

  def fee(amount)
    @fee = amount
    self
  end

  def sign(private_key)
    perform_signature(private_key: private_key)
    self
  end

  private

  def perform_signature(private_key:)
    # ...
  end

end
