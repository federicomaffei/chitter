require 'spec_helper'

describe Peep do
	context 'db model interaction' do
		it 'has no peeps in DB at first' do
			expect(Peep.count).to eq (0)
		end
	end
end