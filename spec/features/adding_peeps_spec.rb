require 'spec_helper'

feature 'A message can be added' do
	scenario 'from the homepage' do
		visit '/'
		add_peep('TEST MESSAGE')
		expect(Peep.count).to eq 1
		peep = Peep.first
		expect(peep.body).to eq 'TEST MESSAGE'
	end
end

feature 'A message shows' do

	before(:each) do
		Maker.create(:email => 'test@test.com', :password => 'pass', :password_confirmation => 'pass', :username => 'user', :name => 'name')
	end

	scenario 'The name of the poster' do
		visit '/'
		sign_in('test@test.com', 'pass')
		add_peep('TEST MESSAGE')
		peep = Peep.first
		expect(page).to include 'user wrote: TEST MESSAGE at'
	end
end
