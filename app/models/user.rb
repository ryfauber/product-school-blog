class User < ActiveRecord::Base
    has_secure_password 
    
    DRIVING_AGE_LIMIT = 16

    has_many :posts
    has_many :comments
    
    def full_name
        "#{first_name} #{last_name}"
    end  
   
    def can_drive?
        age >= DRIVING_AGE_LIMIT
        # if age >=16
        #   true
        # else
        #   false
        # end
    end   
end