require 'sinatra/base'
require_relative './lib/computer'
require_relative './lib/enemies'
require_relative './lib/game'
require_relative './lib/judge'
require_relative './lib/player'
require_relative './lib/rule_book'
require_relative './lib/weapon_cabinet'
require_relative './lib/weapon'

class Rps < Sinatra::Base

  enable :sessions

  get '/' do
    session[:result] = nil
    erb(:index)
  end

  post '/names' do
    player = Player.new(params[:player_name])
    Game.store(player)
    redirect('/play')
  end

  get '/play' do
    @player = Game.show.player
    @result = session[:result]
    erb(:play)
  end

  post '/play_again' do
    session[:result] = nil
    redirect('/play')
  end

  post '/weapon' do
    computer = Game.show.computer
    player = Game.show.player
    player_weapon = player.pick(params[:weapon]).name
    computer_weapon = computer.pick_weapon.name
    session[:result] = Game.show.result(player_weapon, computer_weapon)
    redirect('/play')
  end

  run if app_file == $0
end
