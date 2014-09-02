module SessionHelpers
	def sign_up(email ='test@test.com', password = 'pass', password_confirmation = 'pass', username = 'user', name = 'name')
		visit '/makers/new'
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		fill_in :username, :with => username
		fill_in :name, :with => name
		click_button("Sign Up")
	end

	def sign_in(email, password)
		visit '/sessions/new'
		fill_in "email", :with => email
		fill_in "password", :with => password
		click_button 'Sign in'
	end

	def add_peep(body)
		visit '/'
		fill_in 'body', :with => body
		click_button 'Post Message!'
	end
end
