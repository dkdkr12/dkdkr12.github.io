require 'nokogiri'
require 'open-uri'

uri = "http://ko.pokemon.wikia.com/wiki/%EC%A0%84%EA%B5%AD%EB%8F%84%EA%B0%90/1%EC%84%B8%EB%8C%80"
result = Nokogiri::HTML(open(uri))

result.css('div.mw-content-text tr.bg-white').each do |r|
    puts "이름 : #{r.css('td')[3].text}"
end

    