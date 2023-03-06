class Genre < ApplicationRecord
    validates :name, presence: true, uniqueness: true 
    has_many :characterizations , dependent: :destroy
    has_many :movies, through: :characterizations
    
    
    has_many :tags, as: :tagable
    # has_many :has_tags , through: :tags , source: :tags

    
end
