require 'spec_helper'

feature 'Maker sign up' do
	scenario 'is added to the db' do
		expect(lambda{ sign_up }).to change(Maker, :count).by 1
		expect(Maker.count).to eq 1
	end

	scenario 'is not added to db if password is not confirmed' do
		expect(lambda { sign_up(password = 'pass', password_confirmation = 'wrong')}).to change(Maker, :count).by 0
		expect(Maker.count).to eq 0
	end

	def sign_up(email ='test@test.com', password = 'pass', password_confirmation = 'pass', username = 'user', name = 'name')
		visit '/makers/new'
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		fill_in :username, :with => username
		fill_in :name, :with => name
		click_button("Sign Up")
	end
end