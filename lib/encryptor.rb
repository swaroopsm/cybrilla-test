require "openssl"
require "base64"

module Encryptor

  KEY = "Q9fbkBF8au24C9wshGRW9ut8ecYpyXye5vhFLtHFdGjRg3a4HxPYRfQaKutZx5N4"

  def encrypt(data)
    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    nonce = cipher.random_iv
    cipher.encrypt
    cipher.key = Encryptor::KEY
    cipher.iv = nonce
    encrypted = cipher.update(data) + cipher.final

    return [ Base64.encode64(encrypted), nonce ]
  end

  def decrypt(_data)
    data = Base64.decode64(_data)
    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    decipher.decrypt
    decipher.key = Encryptor::KEY
    decipher.iv = @nonce

    decrypted = decipher.update(data) + decipher.final
 
    return decrypted
  end

end
