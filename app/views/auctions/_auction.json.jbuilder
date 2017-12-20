json.extract! auction, :id, :user_id,:price,:property_id
json.url auction_url(auction, format: :json)
