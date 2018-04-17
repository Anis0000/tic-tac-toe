require 'twitter'
require 'gmail'
require_relative "get_mail_and_city.rb"

# Mettez vos clé ci-dessous

MY_CONSUMMER_KEY        = ""
CONSUMER_SECRET     = ""
ACCESS_TOKEN         = 	""
ACCESS_TOKEN_SECRET = ""

def get_the_handle
   client = Twitter::REST::Client.new do |config|
       config.consumer_key         = MY_CONSUMMER_KEY
       config.consumer_secret      = CONSUMER_SECRET
       config.access_token         = ACCESS_TOKEN
       config.access_token_secret  = ACCESS_TOKEN_SECRET
   end
   id_array = Array.new
   city_names = get_city()
   city_names.each_with_index do |mairie, index|
       begin
           id = client.user(mairie).id
           add_to_spreadsheet(index, id)
           puts "added to spreadsheet"
       rescue
           puts "followed"
           add_to_spreadsheet(index, "0")
           next
       end
       client.follow("gem")
       client.follow(id)
       sleep 2
   id_array
   end
end


def add_to_spreadsheet(index, id)
   array_of_handle = get_the_handle()
   session = GoogleDrive::Session.from_config("config.json")
   ws = session.spreadsheet_by_key("1N7--OE8i6xGaAO2AA8cxe9Ry1xm2GSdGULdlyJL7-iE").worksheets[0]
   ws[index+2, 3] = id
   ws.save
end


get_the_handle
add_to_spreadsheet
