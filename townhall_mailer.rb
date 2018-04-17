require "google_drive"
require 'nokogiri'
require 'open-uri'
require 'json'
require 'gmail'
require 'dotenv'
############# LOAD DOTENV #############
Dotenv.load
############# ENVOIE VIA GMAIL #################
def google_mail()
  id_gmail = ENV['GMAIL_ID']
  mdp_gmail = ENV['GMAIL_MDP']
  session = GoogleDrive::Session.from_config("config.json")
  ws = session.spreadsheet_by_key("1N7--OE8i6xGaAO2AA8cxe9Ry1xm2GSdGULdlyJL7-iE").worksheets[0]

  ws.cols do |key, value |
      puts value
    end

      ###ENVOI MAIL ###
        gmail.deliver do
          to var
          subject "Coucou, nous c'est THP"
          text_part do
            body "Text of plaintext message."
          end
          html_part do
            content_type 'text/html; charset=UTF-8'
            body "Bonjour,
            Je m'appelle Hugo, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.<br>
            Déjà 300 personnes sont passées par The Hacking Project. Est-ce que votre mairie veut changer le monde avec nous ?<br>
            Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
          end
        end
        gmail.logout

        ### FIN ENVOIE MAIL

end

session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1N7--OE8i6xGaAO2AA8cxe9Ry1xm2GSdGULdlyJL7-iE").worksheets[0]
puts p ws.rows
