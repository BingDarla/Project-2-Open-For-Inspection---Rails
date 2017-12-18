json.extract! auction, :id, :user_id,:property_id,:created_at, :updated_at
json.url auction_url(auction, format: :json)
