require_relative '../database/database'
require_relative '../models/user'
require_relative '../constants/user_role'


class UserRepository
  def initialize
    @db = Database.new
  end

  def serialize(user)
    case user["role"]
      when User_Role::ADMIN
        user = Admin.new(user["name"], user["email"], user["password"])
      when User_Role::MANAGER
        user = Manager.new(user["name"], user["email"], user["password"])
      when User_Role::CUSTOMER
        user = Customer.new(user["name"], user["email"], user["password"])
    end
    return user
  end

  def find_user(user)
    users = @db.query_all_users
    i = 0
    while i < users.length
      if user["email"] == users[i]["email"] && user["password"] == users[i]["password"]
        user = serialize(users[i])
        return user
      end
      i += 1
    end
    return nil
  end
end

user_repo = UserRepository.new

puts user_repo.find_user({"email"=>"a@gmail.com","password"=>"a"}).inspect