require 'spec_helper'

feature 'User not logged can browse the list of messages' do
	before(:each) { 
		Peep.create(:body => 'TEST MESSAGE', 
					:posted_by => 'test', 
					:posted_on => '2014-06-21') 
	}

	scenario 'when opening the home page' do
		visit '/'
		expect(page).to have_content('test wrote: TEST MESSAGE at 2014-06-21')
	end

end