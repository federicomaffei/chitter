require 'spec_helper'

feature 'Maker sign up' do
	scenario 'is added to the db' do
		expect(lambda{ sign_up }).to change(Maker, :count).by 1
		expect(Maker.count).to eq 1
	end

	scenario 'is not added to db if password is not confirmed' do
		expect(lambda { sign_up(password = 'pass', password_confirmation = 'wrong')}).to change(Maker, :count).by 0
		expect(Maker.count).to eq 0
		expect(current_path).to eq ('/makers')
	end

	scenario 'and is not added if its email already exists' do
		expect(lambda{ sign_up }).to change(Maker, :count).by 1
		expect(lambda{ sign_up }).to change(Maker, :count).by 0
		expect(page).to have_content "Sorry, this email is already taken"
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

feature 'Maker sign in' do

	before(:each) do
		Maker.create(:email => 'test@test.com', :password => 'pass', :password_confirmation => 'pass', :username => 'user', :name => 'name')
	end

	scenario 'with correct credentials' do
		visit '/'
		expect(page).not_to have_content('Welcome, test@test.com')
		sign_in('test@test.com', 'pass')
		expect(page).to have_content('Welcome, user')
	end

	def sign_in(email, password)
		visit '/sessions/new'
		fill_in "email", :with => email
		fill_in "password", :with => password
		click_button 'Sign in'
	end
 
end