class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :username, presence:true, length:{minimum: 3, maximum: 50}
    validates :email, presence:true, length:{ minimum:10, maximum: 100},
      uniqueness:true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
    validates :password, presence:true, length:{minimum:6, maximum:20}
    has_secure_password
end