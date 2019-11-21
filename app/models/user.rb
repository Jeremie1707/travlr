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

#   def set_initial_password_reset!
#     self.reset_password_token   = Devise.token_generator.generate(self.class, :reset_password_token)
#     self.reset_password_sent_at = Time.now.utc
#     save(validate: false)
#   end
# end

  def set_initial_password_reset!
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)

      self.reset_password_token   = enc
      self.reset_password_sent_at = Time.now.utc
      save(validate: false)
      @token_reset = raw

  end
end
