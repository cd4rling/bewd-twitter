class Session < ApplicationRecord
    belongs_to :user
  
    # Validations
    before_validation :generate_session_token, on: :create
    validates :user_id, presence: true
  
    private
  
    def generate_session_token
      self.token = SecureRandom.urlsafe_base64
    end
  end
  