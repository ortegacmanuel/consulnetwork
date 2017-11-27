require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'json'

class ConsulNetwork < Sinatra::Base
  set :public_folder, 'public'
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/api/cities' do
    content_type :json

    cities = [
      {
        name: 'Madrid',
        url: 'https://decide.madrid.es',
        image: 'decide_madrid.jpg'
      },
      {
        name: 'Puerto Real',
        url: 'https://decide.puertoreal.es',
        image: 'puertoreal.png'
      },
      {
        name: 'Zamora',
        url: 'https://zamoraparticipa.com',
        image: 'zamoraparticipa.png'
      },
      {
        name: 'UDC',
        url: 'https://udcdecide.udc.gal',
        image: ''
      },
      {
        name: 'Gran Canaria',
        url: 'https://participa.grancanaria.com',
        image: 'grancanaria.jpg'
      },
      {
        name: 'Oviedo',
        url: 'http://www.consultaoviedo.es',
        image: 'oviedo.png'
      },
      {
        name: 'Getafe',
        url: 'https://participa.getafe.es',
        image: 'participagetafe.jpg'
      },
      {
        name: 'Benalmádena',
        url: 'https://participa.benalmadena.es',
        image: 'benalmadena.jpg'
      },
      {
        name: 'Ciudad de Buenos Aires',
        url: 'https://baelige.buenosaires.gob.ar',
        image: 'baelige.jpg'
      },
      {
        name: 'קול העם',
        url: 'http://vote.kolhaam.org.il',
        image: 'kolhaamorg.png'
      },
      {
        name: 'Ciudad de Mendoza',
        url: 'http://participa.ciudaddemendoza.gob.ar',
        image: 'ciudadmendoza.jpg'
      },
      {
        name: 'Molina de Seguro',
        url: 'https://decide.molinadesegura.es',
        image: 'molinadesegura.jpg'
      },
      {
        name: 'Calvià',
        url: 'https://www.participacalvia.es',
        image: 'participacalvia.png'
      },
      {
        name: 'Chiloeches',
        url: 'https://decide.aytochiloeches.es',
        image: 'decidechiloeches.jpg'
      },
      {
        name: 'Carreño',
        url: 'https://decide.carreno.es',
        image: 'decidecarreno.jpg'
      },
      {
        name: 'Gobernación de Nariño',
        url: 'https://ganapienso.narino.gov.co',
        image: 'ganapienso.jpg'
      }
    ]

    cities.each do |city|

      begin
        html = open("#{city[:url]}/proposals?order=created_at&page=1")
      rescue Exception => e
        puts "An exception #{e} ocurres during connexion with #{city[:name]} installation"
        next
      end

      doc = Nokogiri::HTML(html)

      proposal = {}

      data = doc.css('div.proposal-content').first

      if !data.nil?
        title_el = data.at_css('h3 a')
        title_el.children.each { |c| c.remove if c.name == 'span' }
        title = title_el.text.strip
        proposal[:title] = title.capitalize

        description_el = data.at_css('div p')
        description = description_el.text.strip
        proposal[:description] = description

        href_el = data.at_css('h3 a')
        href = href_el['href']
        proposal[:href] = href

        city[:proposal] = proposal
      end
    end

    # Delete the cities without proposal
    cities.delete_if { |city| city[:proposal].nil? }
    cities.shuffle!
    cities.to_json
  end
end
