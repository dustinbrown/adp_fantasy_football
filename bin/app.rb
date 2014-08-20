require 'sinatra'
require 'json'
require 'open-uri'

set :bind, '0.0.0.0'
set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

#get list of players in json
players = JSON.parse(open("http://football.myfantasyleague.com/2014/export?TYPE=players&L=&W=&JSON=1").read)

#get list of adp
adp = JSON.parse(open("http://football.myfantasyleague.com/2014/export?TYPE=adp&L=&W=&JSON=1").read)

my_players = []

#Create my_players array with adp plus player details
# I'm sure there are 15 better ways to do this..
players['players']['player'].each do |player|
  adp['adp']['player'].each do |adp|
    if adp['id'] == player['id']
      my_players << { :name => "#{player['name']}", :adp => "#{adp['averagePick']}".to_f, :position => "#{player['position']}", :team => "#{player['team']}", :id => "#{player['id']}" }
    end
  end
end

#listens on port 8080 -- splash page
get '/' do
  #Show adp webpage
  erb :adp, :locals => {'players' => my_players}
end

#Remove player from available list
post '/draft/' do
  #Remove player from array -- uses id from button clicked
  my_players.delete_if {|player| player[:id] == params[:nameid] }

  #Show adp webpage
  erb :adp, :locals => {'players' => my_players}
end

#Show players by position
post '/position/' do
  #Uses post parameter via button clicked
  position = params[:position].upcase

  #Set up position only array
  position_array = []

  #Insert players into array if they match position passed
  my_players.each do |player|
    if player[:position].upcase =~ /#{position}/
      position_array << player
    end
  end

  #Show adp webpage
  erb :adp, :locals => {'players' => position_array}
end
