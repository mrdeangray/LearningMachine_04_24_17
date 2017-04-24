json.extract! card, :id, :question, :answer, :media, :comment, :rep, :level, :category, :user_id, :created_at, :updated_at
json.url card_url(card, format: :json)
