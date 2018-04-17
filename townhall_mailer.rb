require "google_drive"
require 'nokogiri'
require 'open-uri'
require 'json'
require 'gmail'
require 'dotenv'
require_relative 'get_mail_and_name'
############# LOAD DOTENV #############
Dotenv.load

############# ENVOIE DU MAIL #################
def send_mails()
  id_gmail = ENV['GMAIL_ID']
  mdp_gmail = ENV['GMAIL_MDP']
  mails_array = get_mails()
  array_city = get_city()
  mails_array.each_with_index do |mail, index|

    gmail.deliver do
      to mail
      subject "Coucou, nous c'est THP"
      text_part do
        body "Text of plaintext message."
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body
          "Bonjour, <br>
        Je m'appelle Hugo, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de notre école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.<br>
        Déjà 300 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{array_city[index].capitalize} veut changer le monde avec nous ?<br>
        Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
      end
    end
    gmail.logout
  end
end

############# FORMULAIRE D'ENVOI DE MAILS #################

city_number=get_city()

puts "Voulez vous envoyer #{city_number.length} mails aux mairies (y/n)"
answer = gets.chomp
  if answer == "y"
    send_mails()
    puts "#{city_number.length} mails envoyés"
  else
    puts "Mails non envoyés"
  end
