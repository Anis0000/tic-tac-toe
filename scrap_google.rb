require "google_drive"
require 'nokogiri'
require 'open-uri'
session = GoogleDrive::Session.from_config("config.json")
require 'json'

#Lien page google spreadsheet https://docs.google.com/spreadsheets/d/1N7--OE8i6xGaAO2AA8cxe9Ry1xm2GSdGULdlyJL7-iE/edit#gid=0
ws = session.spreadsheet_by_key("").worksheets[0]
#ws[2,1] = "Coucou ahahah"
#ws[2,2] = "Coucou 2"
#ws.save



############## METHODE DE STOCKAGE EN HASH ################
#### Récupération de l'email depuis page web ####
def get_the_email_of_a_townhal_from_its_webpage(temporaire, hashage, name)
  temporaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  hashage[name] = temporaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

#### Récupération des URLS ####
def get_all_the_urls_of_val_doise_townhalls(liens)
  email = Hash.new(0)
  doc = Nokogiri::HTML(open(liens))
  size = doc.css('a.lientxt').length
### Réutilisation de la méthode précédente et stockage  dans une array email"
  for n in 0...size
    tmp = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com#{doc.css('a.lientxt')[n]['href']}"))
    name = doc.css('a.lientxt')[n]['href'].tr('/95/', '').gsub('.html', '').tr('.', '').to_s
    get_the_email_of_a_townhal_from_its_webpage(tmp, email, name)
  end
  return email
end

############# STOCKAGE DANS GOOGLE DOC ##############
def stock_in_google()
        url = 'http://www.annuaire-des-mairies.com/val-d-oise.html'
        hash = get_all_the_urls_of_val_doise_townhalls(url)
        session = GoogleDrive::Session.from_config("config.json")
        ws = session.spreadsheet_by_key("1N7--OE8i6xGaAO2AA8cxe9Ry1xm2GSdGULdlyJL7-iE").worksheets[0]

        ######VERSION EACH ######
        hash.each_with_index do |(key, value), index | # On se sert d'each_with_index pour récupérer un index incrementé

                ws[index+2, 1] = key
                ws[index+2, 2] = value
                ws[index+2, 3] = ""
                end



          ws.save

end

stock_in_google()
