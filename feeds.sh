#!/home/jose/.rvm/rubies/ruby-2.2.4/bin/ ruby

require 'mechanize'



def get_match_link(lnk)

 agent = Mechanize.new

 page = agent.get('https://www.reddit.com' + lnk)
 stream_raw = page.search('body')

 #puts stream_raw.text
 
 if stream_raw.text.include?('acestream:')
   
   ixace = stream_raw.text.index('acestream:')

   #puts "ixace #{ixace}"	
   aceaddr = stream_raw.text[ixace,52]	 

   aceaddr			
 else
   puts "Não existem stream disponiveis para este jogo :("
   nil	
 end


end

agent = Mechanize.new

page = agent.get('https://www.reddit.com/r/soccerstreams/')

matches = page.search('a')

matches_arr =  matches.select{|x| x.text.include?('GMT')}.collect{|x| [x.text, x.attributes['href']]}


matches_arr.each_with_index do |m,i|
  puts "#{i+1} - #{m.first}"	
end

while true

puts ""
puts "Escolha o Jogo que quer ver:"

opt = gets.to_i

if opt < 1 && opt > matches.size
   puts "Opção invalida"
   return
end

#puts matches_arr[opt-1].last
acelnk = get_match_link(matches_arr[opt-1].last)

unless acelnk.nil?   
  system( "firefox #{acelnk}" )
  exit 0	
end

end
