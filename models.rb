require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection('sqlite3:db/development.db')
end

class User < ActiveRecord::Base
  has_secure_password
  has_many :counts
  has_many :user_counts
  has_many :counts, through: :user_counts
end

class Count < ActiveRecord::Base
  belongs_to :user
  has_many :user_counts
  has_many :users, through: :user_counts
end

class UserCount < ActiveRecord::Base
  belongs_to :user
  belongs_to :count
end