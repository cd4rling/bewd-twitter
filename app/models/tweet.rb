class Tweet < ApplicationRecord
    belongs_to :user
  
    # Validations
    validates :message, presence: true, length: { maximum: 140 }
    validates :user_id, presence: true
  end
  