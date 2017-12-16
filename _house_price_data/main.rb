require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'
require 'pry'

def data_ripper (search_suburb, num_pages)

  sub_to_search = search_suburb.to_s.downcase.gsub(' ', '-')
  base_url = 'https://www.realestate.com.au/'
  base_dir = "sold/property-house-in-" + sub_to_search + "/list-"
  # I've called this BASE3 as it's the third paghe to visit.
  base3 = "https://www.domain.com.au/property-profile/"

  local_dir = 'price_data'

  i = 1
  last_page_number = num_pages.to_i
  suburb_data = []
  puts
  puts "searching for " + last_page_number.to_s + " pages of data for " + sub_to_search
  puts


  while i < last_page_number +1 do
  # Start of loop with i for page number
    text_i = i.to_s
    page = Nokogiri::HTML(open(base_url + base_dir + text_i))


    # make a massive array of all the data contained within this CSS selector
    # each row is one house sold.
    rows = page.css('.residential-card__content')
    # binding.pry
    puts
    puts "page : " + text_i
    puts

    rows.each do |row|

      # puts row.children[1].children[0].children[0].children[1]
      suburb =  row.children[1].children[0].children[0].children[7].content
      price = row.children[0].children[0].children[0].content.gsub(',','').gsub('$','')
      # puts row.children[1].children[0].attributes["href"].value

      dir_2 = row.children[1].children[0].attributes["href"].value
      page2 = Nokogiri::HTML(open(base_url + dir_2))
      address1 = page2.css('h1.property-info-address')[0].children[0].children[0].content
      address2 = page2.css('h1.property-info-address')[0].children[1].children[0].content

      features = page2.css('.property-info__general-features')
      bedrooms = features[0].children[0].children[0].children[4].content
      bathrooms = features[0].children[1].children[0].children[4].content

      sold_wordy_date = page2.css('.property-info__secondary-content').children[0].content
      ind1 = sold_wordy_date.index(' on ')
      sold_date = sold_wordy_date[(ind1+3)..(sold_wordy_date.length)].lstrip



      address = address1 + " " + address2


      part_middle = address.downcase.gsub(' ', '-').gsub(',','').gsub('\'','-')
      ind4 = part_middle.index('/')
      ind6 = part_middle.index('&')
      ind7 = part_middle.index('(')
      unless ind4.nil?
        next
      end
      unless ind6.nil?
        next
      end
      unless ind7.nil?
        next
      end

      ind5 = address.index('-')
      unless ind5.nil?
        next
      end


      # pop over to domain.com.au
      # BASE3 = "https://www.domain.com.au/property-profile/"
      page3 = Nokogiri::HTML(open(base3 + part_middle))
      ind3 = page3.content.index('The page you’ve requested does not exist at this address.')

      unless ind3.nil?
        next
      end


      domain_story = page3.css('.proprty-story')

      description = domain_story[0].children[3].children[1]
      ind2 = description.content.index('square')

      if ind2.nil?
        next
      end


      land_size = description.content[(ind2-5)..(ind2-2)].lstrip

      wr_address = domain_story[0].children[3].children[0].children[0].content
      # puts description
      house_data = []

      # puts wr_address
      # puts suburb
      # puts land_size
      # puts price
      # puts bedrooms
      # puts bathrooms
      # puts sold_date
      # puts "page : " + text_i

      print "."

      house_data.push(wr_address, suburb, land_size, price, bedrooms, bathrooms, sold_date)
      suburb_data.push(house_data)


    end # end of the loop (rows)) One per house
    i += 1
  end # of i loop (pages)

  # suburb_data is the collection of all the relevant data. writ it to file.
  puts
  puts "Writing data to file..."
  puts
  File.open("#{local_dir}/#{sub_to_search}.html", 'w').write(suburb_data)



end

# puts "If in pry, call function: data_ripper(bondi, 2)"
# binding.pry
puts "The suburbs to search are called from the bottom of this file, main.rb."
# data_ripper("bondi", 8)
# data_ripper("asquith", 8)
# data_ripper("fairfield", 8)
# data_ripper("marrickville", 8)
data_ripper("newtown", 8)
