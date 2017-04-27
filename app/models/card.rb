class Card < ApplicationRecord
    belongs_to :user
    validates :user_id, presence: true
    # set_primary_key :id
end
