class User < ApplicationRecord
    # User has participated in many trips
    has_many :participants, dependent: :destroy
    has_many :trips, through: :participants

    # User has many expenses
    # has_many :expense, dependent: :destroy
    
    # Validations
    # before_save { self.email = email.downcase }
    # validates :username, presence:{message:'Name is required'}, length:{minimum: 2, maximum: 50}
    # validates :email, presence:true, length:{ minimum:10, maximum: 100},
    #   uniqueness:true
    # validates :password, presence:true, length:{minimum:6, maximum:20}
    has_secure_password
end