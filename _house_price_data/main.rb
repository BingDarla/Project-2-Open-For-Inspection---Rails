require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'
require 'pry'

SUB_TO_SEARCH = "bondi"
BASE_URL = 'https://www.realestate.com.au/'
base_dir = "sold/property-house-in-" + SUB_TO_SEARCH + "/list-"

BASE3 = "https://www.domain.com.au/property-profile/"

LOCAL_DIR = 'price_data'


i = 1
last_page_number = 1
suburb_data = []

while i < last_page_number +1 do
# Start of loop with i for page number
  text_i = i.to_s
  page = Nokogiri::HTML(open(BASE_URL+base_dir + text_i))
  i += 1

  # make a massive array of all the data contained within this CSS selector
  # each row is one house sold.
  rows = page.css('.residential-card__content')

  rows.each do |row|
    # puts row.children[1].children[0].children[0].children[1]
    suburb =  row.children[1].children[0].children[0].children[7].content
    price = row.children[0].children[0].children[0].content.gsub(',','').gsub('$','')
    # puts row.children[1].children[0].attributes["href"].value

    dir_2 = row.children[1].children[0].attributes["href"].value
    page2 = Nokogiri::HTML(open(BASE_URL+dir_2))
    address1 = page2.css('h1.property-info-address')[0].children[0].children[0]
    address2 = page2.css('h1.property-info-address')[0].children[1].children[0]

    features = page2.css('.property-info__general-features')
    bedrooms = features[0].children[0].children[0].children[4].content
    bathrooms = features[0].children[1].children[0].children[4].content

    sold_wordy_date = page2.css('.property-info__secondary-content').children[0].content
    ind1 = sold_wordy_date.index(' on ')
    sold_date = sold_wordy_date[(ind1+3)..(sold_wordy_date.length)].lstrip



    address = address1.content + " " + address2.content


    part_middle = address.downcase.gsub(' ', '-').gsub(',','')
    ind4 = part_middle.index('/')
    unless ind4.nil?
      next
    end

    ind5 = address.index('-')
    unless ind5.nil?
      next
    end


    # pop over to domain.com.au
    page3 = Nokogiri::HTML(open(BASE3+part_middle))
    ind3 = page3.content.index('The page you’ve requested does not exist at this address.')

    unless ind3.nil?
      next
    end


    domain_story = page3.css('.proprty-story')

    description = domain_story[0].children[3].children[1]
    ind2 = description.content.index('square')
    land_size = description.content[(ind2-5)..(ind2-2)].lstrip

    wr_address = domain_story[0].children[3].children[0].children[0].content
    # puts description
    house_data = []

    puts wr_address
    puts suburb
    puts land_size
    puts price
    puts bedrooms
    puts bathrooms
    puts sold_date
    puts i

    house_data.push(wr_address, suburb, land_size, price, bedrooms, bathrooms, sold_date)
    suburb_data.push(house_data)


  end # end of the loop (rows)) One per house

end # of i loop (pages)



File.open("#{LOCAL_DIR}/#{SUB_TO_SEARCH}.html", 'w').write(suburb_data)
