class Tag < ApplicationRecord
   belongs_to :tagable , polymorphic: true 
   # belongs_to :movie
end
