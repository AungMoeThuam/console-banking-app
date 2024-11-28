require "securerandom"
def generate_unique_id
  hex_1= SecureRandom.hex(2) #generate random hexadecimal number with length of 4 chars
  hex_2 = SecureRandom.hex(2)
  hex_3 = SecureRandom.hex(2)
  hex_4 = SecureRandom.hex(2)
  "#{hex_1}-#{hex_2}-#{hex_3}-#{hex_4}"
end

