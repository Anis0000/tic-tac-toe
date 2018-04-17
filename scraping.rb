 require "google_drive"
require 'nokogiri'
require 'open-uri'
require 'json'

############## METHODE DE STOCKAGE EN HASH ################
#### Récupération de l'email depuis page web ####
def get_the_email_of_a_townhal_from_its_webpage(temporaire, hashage, name)
  temporaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  hashage[name] = temporaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

#### Récupération des URLS ####
def get_all_the_urls_of_townhalls(liens)
  email = Hash.new(0)
  doc = Nokogiri::HTML(open(liens))
  size = doc.css('a.lientxt').length
### Réutilisation de la méthode précédente et stockage  dans une array email ###
  for n in 0...size
    tmp = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com#{doc.css('a.lientxt')[n]['href']}"))
    name = doc.css('a.lientxt')[n]['href'].tr('/29/', '').tr('/33/','').tr('/18/', '').gsub('.html', '').tr('.', '').to_s
    get_the_email_of_a_townhal_from_its_webpage(tmp, email, name)
  end
  return email
end

############# STOCKAGE DANS GOOGLE DOC ##############
def stock_in_google(array_url)

	hash = Hash.new
	array_url.each do |url|
		puts ".."
        	hash = hash.merge(get_all_the_urls_of_townhalls(url))
		puts ".........."
	end
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


############# APPEL DES FONCTIONS #################
stock_in_google(["https://www.annuaire-des-mairies.com/finistere.html",
		 "https://www.annuaire-des-mairies.com/finistere-2.html",
		 "http://www.annuaire-des-mairies.com/gironde.html",
		 "http://www.annuaire-des-mairies.com/gironde-2.html",
		 "http://www.annuaire-des-mairies.com/gironde-3.html",
		 "http://www.annuaire-des-mairies.com/cher.html",
		 "http://www.annuaire-des-mairies.com/cher-2.html"])
