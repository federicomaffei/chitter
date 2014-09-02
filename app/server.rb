require 'sinatra'
require 'rack-flash'
require 'data_mapper'
require './lib/maker'
require './lib/peep'

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/chitter_#{env}")
DataMapper.finalize
DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
set :public_folder, 'assets'
set :root, File.dirname(__FILE__)
enable :static

def current_maker
	@current_maker ||= Maker.get(session[:maker_id]) if session[:maker_id]
end

get '/' do
	@peeps = Peep.all
	erb :index
end

get '/makers/new' do
	@maker = Maker.new
	erb :"/makers/new"
end

get '/sessions/new' do
	erb :'sessions/new'
end

post '/new_peep' do
	body = params[:body]
	peep = Peep.create(:body => body, :posted_by => current_maker.username, :posted_on => Date.today.to_s)
	redirect to('/')
end

post '/sign_up' do
	redirect to '/makers/new'
end

post '/sign_in' do
	redirect to 'sessions/new'
end

post '/makers' do
	email = params[:email]
	password = params[:password]
	password_confirmation = params[:password_confirmation]
	username = params[:username]
	name = params[:name]
	@maker = Maker.new(:email =>email, :password => password, :password_confirmation => password_confirmation, :username => username, :name => name)
	if @maker.save
		session[:maker_id] = @maker.id
		redirect to('/')
	else
		flash.now[:errors] = @maker.errors.full_messages
		erb :'/makers/new' 
	end
end

post '/sessions' do
	email = params[:email]
	password = params[:password]
	maker = Maker.authenticate(email, password)
	if maker
		session[:maker_id] = maker.id
		redirect to('/')
	else
		flash[:errors] = ['Email or password is incorrect']
		erb :'sessions/new'
	end
end

delete '/sessions' do
	session[:maker_id] = nil
	flash[:notice] = 'Thanks for using chitter!'
	redirect to '/'
end
