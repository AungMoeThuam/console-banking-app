require 'json'
class Database
  attr_accessor :data
  def initialize
      path="/data/data.json"
      path = File.join(File.dirname(__FILE__), path)
      file = File::open(path,"r")
      data = file.read
      file.close
      @data = JSON.parse(data)
  end

  def query_all_users()
    return  @data["users"]
  end

end

db = Database.new
puts db.query_all_users



