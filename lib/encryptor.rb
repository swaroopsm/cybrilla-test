require "openssl"
require "base64"

module Encryptor

  KEY = "Q9fbkBF8au24C9wshGRW9ut8ecYpyXye5vhFLtHFdGjRg3a4HxPYRfQaKutZx5N4"
  IV = "NONCE"

  def encrypt(data)
    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.encrypt
    cipher.key = Encryptor::KEY
    iv = Encryptor::IV
    encrypted = cipher.update(data) + cipher.final

    return Base64.encode64(encrypted)
  end

  def decrypt(data)
    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    decipher.decrypt
    decipher.key = Encryptor::KEY
    decipher.iv = Encryptor::IV

    plain = decipher.update(data) + decipher.final

    return plain
  end

end
