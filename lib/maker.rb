require 'bcrypt'

class Maker

	include DataMapper::Resource

	has n, :peeps, :through => Resource
	
	property :id, Serial
	property :email, String, :unique => true
	property :password_digest, Text
	property :username, String
	property :name, String

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end
end