class User < ApplicationRecord
  before_save :formate_username
  before_save :set_slug

  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true
  validates :email, presence: true,
    format:{ with: /\S+@\S+/ }, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6,allow_blank: true}
  validates :username,presence: true,
    format: {with: /\A[A-Z0-9]+\z/i },uniqueness: {case_sensitive: false}

  scope :by_name, -> { order(:name) }
  scope :not_admin, -> { by_name.where(admin: false) }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

    # def to_param
    #   slug
    # end

  private 

  def formate_username
    self.username = username.downcase
  end

  def set_slug
    self.slug = name.parameterize
  end

end
