class HomeController < ApplicationController
  
  def start

  end

  def index
    @poke = Pokemon.all
  end
  
  def nokogiri_poke
    
    require 'nokogiri'
    require 'open-uri'

    
    uri = "http://ko.pokemon.wikia.com/wiki/%EC%A0%84%EA%B5%AD%EB%8F%84%EA%B0%90/1%EC%84%B8%EB%8C%80"
    result = Nokogiri::HTML(open(uri))
    @poke_array = Array.new
    
    result.css('div.mw-content-text tr.bg-white').each do |r|
      @poke_array.push("#{r.css('td').css('a')[0]['href']}")
    end
    
    @poke_array.each do |x|
      uri = "http://ko.pokemon.wikia.com" + "#{x}"
      poke = Nokogiri::HTML(open(uri))

      poke.css('div.mw-content-text').each do |r|
        new_pokemon = Pokemon.new
        new_pokemon.content = r.css('p')[1].text
        new_pokemon.num = r.css('div.index').text
        new_pokemon.name = r.css('div.name div.name-ko').text
        new_pokemon.image = r.css('div.image.rounded').css('img')[0]['data-src']
        new_pokemon.save
      end
    end
    
    redirect_to "/home/index"
    
    
  end
  
  def edit
    @one_poke = Pokemon.find(params[:pokemon_id])
  end
  
  def update
    @one_poke = Pokemon.find(params[:pokemon_id])
    @one_poke.name = params[:poke_name]
    @one_poke.content = params[:poke_content]
    @one_poke.save
    redirect_to "/home/index"
  end
  
  def destroy
    @one_poke = Pokemon.find(params[:pokemon_id])
    @one_poke.destroy
    
    redirect_to "/home/index"
  end
  
end
