require 'spec_helper'

describe Peep do
	context 'db model interaction' do
		it 'has no peeps in DB at first' do
			expect(Peep.count).to eq (0)
		end

		it 'has a peep saved in DB if created' do
			Peep.create(:body => 'TEST MESSAGE', :posted_by => 'test', :posted_at => '2014-06-21 15:52:07 +0100')
			expect(Peep.count).to eq 1
			peep = Peep.first
			expect(peep.body).to eq 'TEST MESSAGE'
		end

		it 'has no peeps in DB if one is deleted' do
			Peep.create(:body => 'TEST MESSAGE', :posted_by => 'test', :posted_at => '2014-06-21 15:52:07 +0100')
			peep = Peep.first
			peep.destroy
			expect(Peep.count).to eq 0
		end
	end
end