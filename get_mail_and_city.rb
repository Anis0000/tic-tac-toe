require "google_drive"
require 'nokogiri'
require 'open-uri'
require 'json'
require 'gmail'
require 'dotenv'
############# LOAD DOTENV #############
Dotenv.load
############# RECUPERATION DES MAILS ET DU NOM #################
def get_column(col_title)
  id_gmail = ENV['GMAIL_ID']
  mdp_gmail = ENV['GMAIL_MDP']
  session = GoogleDrive::Session.from_config("config.json")
  ws = session.spreadsheet_by_key("1N7--OE8i6xGaAO2AA8cxe9Ry1xm2GSdGULdlyJL7-iE").worksheets[0]
  gmail = Gmail.connect!(id_gmail, mdp_gmail)
  i = 0
  column = Array.new
  while i < ws.num_rows do
    column.push(ws.list[i][col_title])
    i += 1
  end
  column
end

def get_mails()
  get_column("email")
end

def get_city()
  get_column("ville")
end
