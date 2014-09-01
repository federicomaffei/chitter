require 'spec_helper'

feature 'A message can be added' do

	before(:each) do
		Maker.create(:email => 'test@test.com', :password => 'pass', :password_confirmation => 'pass', :username => 'user', :name => 'name')
	end

	scenario 'from the homepage' do
		visit '/'
		sign_in('test@test.com', 'pass')
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

	scenario 'the name of the poster' do
		visit '/'
		sign_in('test@test.com', 'pass')
		add_peep('TEST MESSAGE')
		peep = Peep.first
		expect(page).to have_content 'user wrote: TEST MESSAGE at'
	end

	scenario 'the date of the posting' do
		visit '/'
		sign_in('test@test.com', 'pass')
		add_peep('TEST MESSAGE')
		peep = Peep.first
		expect(page).to have_content "user wrote: TEST MESSAGE at #{Date.today.to_s}"
	end
end
