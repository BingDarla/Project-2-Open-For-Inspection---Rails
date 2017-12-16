require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'
BASE_URL = 'https://www.realestate.com.au/'
BASE_DIR = 'sold/property-house-in-bondi/list-'
LOCAL_DIR = 'dump'

# https://www.realestate.com.au/sold/in-bondi%3b/list-1
# https://www.realestate.com.au/sold/property-house-in-bondi/list-1

FileUtils.makedirs(LOCAL_DIR) unless File.exists?LOCAL_DIR

# get metainfo from first page:
page = Nokogiri::HTML(open(BASE_URL+BASE_DIR + '1'))
last_page_number = 3


# write the HTML for page 1 to disk
# File.open("#{LOCAL_DIR}/all.html", 'w'){|f| f.write(page.css('.property-price'))}



puts "Iterating from 1 to #{last_page_number}"

for pg_number in 1..last_page_number do
  puts "Getting #{pg_number}"
  File.open("#{LOCAL_DIR}/all.html", 'w') do |f|
    # This writes the prices
    # f.write( Nokogiri::HTML(open(BASE_URL+BASE_DIR + "#{pg_number}")).css('.property-price'));
    #This writes all info
    f.write( Nokogiri::HTML(open(BASE_URL+BASE_DIR + "#{pg_number}")).css('.residential-card__content'))





  end
end

# .5r7jwc6vfo.3.1.3.1:$2013521375.0.1.1.0.0
# .5r7jwc6vfo.3.1.3.1:$2013527937.0.1.1.0.0
