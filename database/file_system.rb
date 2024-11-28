require 'json'
class FileSystem

  def read_users
    #read file from json data file
    path ="/data/data.json"
    path = File.join(File.dirname(__FILE__), path)
    file = File::open(path,"r")
    data = file.read
    file.close
    return JSON.parse(data) #convert json to hash
  end

  def write_users(data)
    #write file to json data file
    data = data.to_json #convert hash to json
    path ="/data/data.json"
    path = File.join(File.dirname(__FILE__), path)
    file = File::open(path,"w")
    file.write(data)
    file.close
  end

end




