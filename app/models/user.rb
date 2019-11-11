class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :trips, through: :participants
  has_many :participants, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :trip_items, dependent: :destroy
  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'
  mount_uploader :photo, PhotoUploader
  devise :invitable, :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    (first_name.nil? || last_name.nil?) ? email : (first_name + " " + last_name)
  end
end
