class User < ApplicationRecord
  has_secure_password
  before_save :email_downcase
  has_many :contacts


  validates :name, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }
  private
  def email_downcase
    self.email.downcase!
  end
end
