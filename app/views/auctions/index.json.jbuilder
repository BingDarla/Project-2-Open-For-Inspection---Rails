# json.array! @auctions, partial: 'auctions/auction', as: :auction

json.auctions @auctions do |auction|
  json.price auction.price

  json.property_id auction.property.id
  json.address auction.property.address
  json.userName  auction.user.name
  json.email     auction.user.email
  json.time      auction.created_at

end
