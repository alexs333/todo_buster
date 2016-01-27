require 'spec_helper'
require 'todo_buster/configuration'

describe TodoBuster::Configuration do
  context 'default' do
    before do
      TodoBuster.configure
    end

    it 'should have a default valid period of one month' do
      expect(TodoBuster.configuration.valid_period).to eql 1.month
    end
  end
end
