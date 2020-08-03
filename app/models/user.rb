class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_confirmation, :if => :password_digest_changed?
  validates :password, presence: true, confirmation: true
  has_secure_password

  before_create :assign_api_key

  private
  def assign_api_key
    self.api_key = SecureRandom.uuid
  end
end
