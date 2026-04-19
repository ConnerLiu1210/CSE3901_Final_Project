class User < ApplicationRecord
    has_many :trips, dependent: :destroy
    
    # before_save { self.email = email.downcase }
    # validates :username, presence:{message:'Name is required'}, length:{minimum: 2, maximum: 50}
    # validates :email, presence:true, length:{ minimum:10, maximum: 100},
    #   uniqueness:true
    # validates :password, presence:true, length:{minimum:6, maximum:20}
    has_secure_password
end