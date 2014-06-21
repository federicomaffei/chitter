require 'bcrypt'

class Maker

	include DataMapper::Resource

	has n, :peeps, :through => Resource

	property :id, Serial
	property :email, String, :unique => true
	property :password_digest, Text
	property :username, String
	property :name, String



end