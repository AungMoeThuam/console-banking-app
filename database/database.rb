require 'json'
def read_file(path="/data/data.json")
  path = File.join(File.dirname(__FILE__), path)
  file = File::open(path,"r")
  data = file.read
  file.close
  return JSON.parse(data)
end




