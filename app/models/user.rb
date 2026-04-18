class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :trip_memberships, dependent: :destroy
    has_many :trips, through: :trip_memberships
    has_many :created_trips, class_name: "Trip", foreign_key: :user_id, dependent: :destroy
    has_many :expense_splits, dependent: :destroy
    has_many :paid_expenses, class_name: "Expense", foreign_key: :user_id, dependent: :destroy
    before_save { self.email = email.downcase }
    validates :name, presence:{message:'Name is required'}, length:{minimum: 5, maximum: 50}
    validates :email, presence:true, length:{ minimum:10, maximum: 100}, 
      uniqueness:true,format:{with: /\A([A-Za-z]+\.\d+@osu\.edu)|(\w+@gmail\.com)\Z/i ,
    message:'Only OSU or Gmail'
    }
    validates :password, presence:true, length:{minimum:6, maximum:20}
    has_secure_password
end
