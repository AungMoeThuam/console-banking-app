def add_space_to_right(str)
  max = 21
  str.ljust(max," ")
end

def add_space_to_left(str)
  max  = 13
  str.rjust(space," ")
end

print add_space_to_right("aaba-abda-bada-adab")
print add_space_to_right("a")
