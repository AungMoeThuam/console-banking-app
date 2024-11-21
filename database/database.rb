require 'json'
class Database
  attr_accessor :data
  def initialize
      path ="/data/data.json"
      path = File.join(File.dirname(__FILE__), path)
      file = File::open(path,"r")
      data = file.read
      file.close
      @data = JSON.parse(data)
  end

  def read_users()
    return  @data["users"]
  end

  def write_users(users)
    data = users.to_json
    path ="/data/data.json"
    path = File.join(File.dirname(__FILE__), path)
    file = File::open(path,"w")
    file.write(data)
    file.close

  end

end

db = Database.new
puts db.read_users



