require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/chitter_#{env}")

require './lib/maker'
require './lib/peep'

DataMapper.finalize

DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'

def current_maker
	@current_maker ||= Maker.get(session[:maker_id]) if session[:maker_id]
end

get '/' do
	@peeps = Peep.all
	erb :index
end

get '/makers/new' do
	erb :"/makers/new"
end

post '/new_peep' do
	body = params[:body]
	peep = Peep.create(:body => body)
	redirect to('/')
end

post '/sign_up' do
	redirect to '/makers/new'
end

post '/makers' do
	email = params[:email]
	password = params[:password]
	password_confirmation = params[:password_confirmation]
	username = params[:username]
	name = params[:name]
	maker = Maker.create(:email =>email, :password => password, :password_confirmation => password_confirmation, :username => username, :name => name)
	session[:maker_id] =maker.id
	redirect('/')
end
