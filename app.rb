require 'open-uri'
require 'nokogiri'
require 'byebug'

class ConsulNetwork < Sinatra::Base
  set :public_folder, 'public'
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do

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
      }
    ]

    cities.each do |city|
      html = open("#{city[:url]}/proposals?order=created_at&page=1")

      doc = Nokogiri::HTML(html)

      proposal = {}

      data = doc.css('div.proposal-content').first

      if !data.nil?
        title_el = data.at_css('h3 a')
        title_el.children.each { |c| c.remove if c.name == 'span' }
        title = title_el.text.strip
        proposal[:title] = title

        description_el = data.at_css('div p')
        description = description_el.text.strip
        proposal[:description] = description

        city[:proposal] = proposal
      end

    end
    erb :index, locals: {cities: cities}
  end
end
