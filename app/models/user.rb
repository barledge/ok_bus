class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :votes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username,
    presence: true,
    uniqueness: true
  mount_uploader :profile_photo, ProfilePhotoUploader

  after_create :send_email
  def send_email
    UserMailer.welcome_email(self).deliver
  end

  def authorized_to_edit?(review)
    admin? || id == review.user_id
  end

  protected

  def confirmation_required?
    false
  end
end
