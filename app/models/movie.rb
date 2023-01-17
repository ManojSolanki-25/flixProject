class Movie < ApplicationRecord

    before_save :set_slug
    has_many :reviews, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :fans, through: :favorites, source: :user 
    has_many :characterizations, dependent: :destroy
    has_many :genres, through: :characterizations

    validates :name, presence: true, uniqueness: true
    validates :description ,length: {minimum: 25}
    validates :total_gross, numericality: {greater_than_or_equal_to: 0 }
    validates :image_file_name, format:{
        with: /\w+\.(jpg|png)\z/i,
        message: "must be a JPG or PNG image"
    }

    scope :released, -> { where("released_on < ?", Time.now).order(released_on: :desc) } 
    scope :upcoming, lambda {      where("released_on > ?", Time.now).order(released_on: :desc)}
    scope :recent, lambda { |max=5| released.limit(max) }
    scope :hits, -> {released.where("total_gross >= 300000000").order(total_gross: :desc) }
    scope :flops, -> {released.where("total_gross < 225000000").order(total_gross: :asc)}

    def free?
        total_gross.blank? || total_gross.zero?
    end
    
    #  def self.released
    #     where("released_on < ?", Time.now).order(released_on: :desc)
    #  end

    #  def self.upcoming
    #     where("released_on > ?", Time.now).order(released_on: :desc)
    #  end

     def average_stars
        reviews.average(:stars) || 0.0
     end

     def average_stars_as_percent
         (self.average_stars/5.0)*100
     end

     def to_param
        slug
     end

     private
     
     def set_slug
        self.slug =  name.parameterize
     end
end
