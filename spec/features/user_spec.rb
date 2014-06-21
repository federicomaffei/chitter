require 'spec_helper'
require './lib/user'

describe User do

	context 'sign up' do
		it 'has no users in DB at first' do
			expect(User.count).to eq (0)
		end

		it 'has a user saved in DB if created' do
			User.create(:email => 'test@test.com', :password_digest => 'blablabla', :username => 'user', :name => 'name')
			expect(User.count).to eq 1
		end
	end
end