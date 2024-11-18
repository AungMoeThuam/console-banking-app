def read_integer(prompt)
  print prompt
  return  gets.chomp.to_i
end

def read_string(prompt)
  print prompt
  return gets.chomp
end