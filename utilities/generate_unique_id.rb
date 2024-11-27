require "securerandom"
def generate_unique_id
  hex_1= SecureRandom.hex(2)
  hex_2 = SecureRandom.hex(2)
  hex_3 = SecureRandom.hex(2)
  hex_4 = SecureRandom.hex(2)
  return "#{hex_1}-#{hex_2}-#{hex_3}-#{hex_4}"
end

puts generate_unique_id
