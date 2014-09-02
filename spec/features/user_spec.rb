require 'spec_helper'
require './lib/maker'

describe Maker do
	context 'db model interaction' do
		it 'has no makers in DB at first' do
			expect(Maker.count).to eq (0)
		end

		it 'has a maker saved in DB if created' do
			Maker.create(:email => 'test@test.com', :password_digest => 'blablabla', :username => 'user', :name => 'name')
			expect(Maker.count).to eq 1
			user = Maker.first
			expect(user.username).to eq 'user'
		end

		it 'has no makers in DB if one is deleted' do
			Maker.create(:email => 'test@test.com', :password_digest => 'blablabla', :username => 'user', :name => 'name')
			user = Maker.first
			user.destroy
			expect(Maker.count).to eq 0
		end
	end
end