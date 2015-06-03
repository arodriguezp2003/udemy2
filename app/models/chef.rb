class Chef < ActiveRecord::Base
    has_many :recipes
    has_many :likes
    
    before_save { self.email = email.downcase }
    validates :chefname, presence: true, length: {minimum: 3 , maximum: 40}
    validates :email, presence: true, length: {maximum: 105}, uniqueness: { case_sensitive: false },
                        format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
    has_secure_password
end