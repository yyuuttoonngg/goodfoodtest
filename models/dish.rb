class Dish < ActiveRecord::Base
    has_many :comments
    belongs_to :user
    has_many :likes
end

#convention class name is the sigular form of the talbe name class-> Dish, matching talbe->dishes