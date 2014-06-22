require 'spec_helper'

feature 'A message can be added' do
	scenario 'from the homepage' do
		visit '/'
		add_peep('TEST MESSAGE')
		expect(Peep.count).to eq 1
		peep = Peep.first
		expect(peep.body).to eq 'TEST MESSAGE'
	end

	def add_peep(body)
		within('#new_peep') do
			fill_in 'body', :with => body
			click_button 'Post Message!'
		end
	end
end
