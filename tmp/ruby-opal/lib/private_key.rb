class PrivateKey
  def initialize(private_key)
    @private_key_string = private_key
  end

  def to_address
    # @private_key_string use bitcore via opal to convert to address
    "1...."
  end
end
