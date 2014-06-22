require 'bcrypt'

class Maker

	include DataMapper::Resource

	has n, :peeps, :through => Resource

	property :id, Serial
	property :email, String, :unique => true, :message => 'Sorry, this email is already taken.'
	property :password_digest, Text
	property :username, String
	property :name, String

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password, :message => "This email is already taken"

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		maker = Maker.first(:email => email)
		if maker && BCrypt::Password.new(maker.password_digest) == password
			maker
		else
			nil
		end
	end

end