require_relative '../constants/user_role'
require "json"
class User
  attr_accessor :name,:email,:password,:role
  def initialize(name,email,password)
    @name = name
    @email = email
    @password = password
  end

  def to_json
    hash = {"name" => @name, "email" => @email, "password" => @password,"role" => @role}
    hash.to_json
  end
end

class Admin < User
  attr_accessor :permissions, :role

  def initialize(name, email, password)
    super(name,email,password)
    @role = User_Role::ADMIN
  end
end

class Manager < User
  attr_accessor :permissions, :role
  def initialize(name,email,password)
    super(name,email,password)
    @role=User_Role::MANAGER
  end
end

class Customer < User
  attr_accessor :permissions, :accounts, :role
  def initialize(name,email,password)
    super(name,email,password)
    @role=User_Role::CUSTOMER
    @accounts = []
  end
end