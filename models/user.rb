class User
  attr_accessor :name,:email,:password,:accounts,:role
  def initialize(name,email,password,accounts=[],role=User_Role::CUSTOMER)
    @name = name
    @email = email
    @password = password
    @accounts = accounts
    @role = role
  end
end