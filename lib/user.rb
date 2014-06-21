require 'bcrypt'
require 'data_mapper'
require './app/data_mapper_setup'

class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String, :unique => true
	property :password_digest, Text
	property :username, String
	property :name, String

end