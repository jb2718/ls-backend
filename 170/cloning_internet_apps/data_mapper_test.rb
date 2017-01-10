require 'data_mapper'

DataMapper.setup(:default, 'sqlite://localhost/test.db')

class User
  include DataMapper::Resource

  property :id,             Serial    # An auto-increment integer key
  property :email,          String,     :length => 255
  property :nickname,       String,     :length => 255
  property :birth_date,     DateTime
  property :education,      Text
  property :work_history,   Text
  property :description,    Text
  
  has 1, :account
end


class Account
  include DataMapper::Resource
  
  property :id, Serial
  belongs_to, :user
end