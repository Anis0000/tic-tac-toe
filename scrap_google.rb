require "google_drive"
require 'nokogiri'
require 'open-uri'
<<<<<<< HEAD
require 'json'
require 'gmail'
require 'dotenv'

############# LOAD DOTENV #############
Dotenv.load
############# APPEL DES CLEFS #############
=begin
ENV[TWITTER_API_KEY]
ENV[TWITTER_API_SECRET]
ENV[TWITTER_TOKEN_KEY]
ENV[TWITTER_TOKEN_SECRET]
=end
id_gmail = ENV['GMAIL_ID']
mdp_gmail = ENV['GMAIL_MDP']

############# VARIABLES #############
=======
session = GoogleDrive::Session.from_config("config.json")
require 'json'

#Lien page google spreadsheet https://docs.google.com/spreadsheets/d/1N7--OE8i6xGaAO2AA8cxe9Ry1xm2GSdGULdlyJL7-iE/edit#gid=0
ws = session.spreadsheet_by_key("").worksheets[0]
#ws[2,1] = "Coucou ahahah"
#ws[2,2] = "Coucou 2"
#ws.save

>>>>>>> 330413cd2075bcfa14c97c8dfacda4fcea49ea8b


############## METHODE DE STOCKAGE EN HASH ################
#### Récupération de l'email depuis page web ####
def get_the_email_of_a_townhal_from_its_webpage(temporaire, hashage, name)
  temporaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  hashage[name] = temporaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

#### Récupération des URLS ####
<<<<<<< HEAD
def get_all_the_urls_of_townhalls(liens)
  email = Hash.new(0)
  doc = Nokogiri::HTML(open(liens))
  size = doc.css('a.lientxt').length
### Réutilisation de la méthode précédente et stockage  dans une array email ###
  for n in 0...size
    tmp = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com#{doc.css('a.lientxt')[n]['href']}"))
    name = doc.css('a.lientxt')[n]['href'].tr('/04/', '').gsub('.html', '').tr('.', '').to_s
=======
def get_all_the_urls_of_val_doise_townhalls(liens)
  email = Hash.new(0)
  doc = Nokogiri::HTML(open(liens))
  size = doc.css('a.lientxt').length
### Réutilisation de la méthode précédente et stockage  dans une array email"
  for n in 0...size
    tmp = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com#{doc.css('a.lientxt')[n]['href']}"))
    name = doc.css('a.lientxt')[n]['href'].tr('/95/', '').gsub('.html', '').tr('.', '').to_s
>>>>>>> 330413cd2075bcfa14c97c8dfacda4fcea49ea8b
    get_the_email_of_a_townhal_from_its_webpage(tmp, email, name)
  end
  return email
end

############# STOCKAGE DANS GOOGLE DOC ##############
def stock_in_google()
<<<<<<< HEAD
        url = 'http://www.annuaire-des-mairies.com/alpes-de-haute-provence.html'
        hash = get_all_the_urls_of_townhalls(url)
=======
        url = 'http://www.annuaire-des-mairies.com/val-d-oise.html'
        hash = get_all_the_urls_of_val_doise_townhalls(url)
>>>>>>> 330413cd2075bcfa14c97c8dfacda4fcea49ea8b
        session = GoogleDrive::Session.from_config("config.json")
        ws = session.spreadsheet_by_key("1N7--OE8i6xGaAO2AA8cxe9Ry1xm2GSdGULdlyJL7-iE").worksheets[0]

        ######VERSION EACH ######
        hash.each_with_index do |(key, value), index | # On se sert d'each_with_index pour récupérer un index incrementé

                ws[index+2, 1] = key
                ws[index+2, 2] = value
                ws[index+2, 3] = ""
                end
<<<<<<< HEAD
                ws.save
end


############# ENVOIE VIA GMAIL #################
def google_mail()
  gmail = Gmail.connect!(id_gmail, mdp_gmail)
  puts "Quel est le sujet de vos mails ?"
  subject_mail=gets.chomp

    ###ENVOI MAIL ###
      gmail.deliver do
        to var
        subject subject_mail
        text_part do
          body "Text of plaintext message."
        end
        html_part do
          content_type 'text/html; charset=UTF-8'
          body "<p>Text of <em>AHAH</em> message.</p>"
        end
      end
      ### FIN ENVOIE MAIL

  gmail.logout
end

############# APPEL DES FONCTIONS #################
=======



          ws.save

end

>>>>>>> 330413cd2075bcfa14c97c8dfacda4fcea49ea8b
stock_in_google()
