require 'dm-timestamps'

class Peep

	include DataMapper::Resource

	has 1, :maker, :through => Resource

	property :id, Serial
	property :body, Text
	property :posted_by, String
	property :posted_on, Date

end