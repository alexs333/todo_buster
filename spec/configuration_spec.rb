require 'spec_helper'
require 'todo_buster/configuration'
require 'todo_buster/configurators/output_dir_configurator'
require 'todo_buster/configurators/reports_configurator'
require 'todo_buster/configurators/valid_period_configurator'

describe TodoBuster::Configuration do
  context 'default' do
    before do
      TodoBuster.configure
    end

    it 'should have a default valid period of one month' do
      expect(TodoBuster.configuration.valid_period).to eql 1.month
    end
  end

  context 'when configuration file is present' do
    let(:config_file) { "valid-period=1.minute\noutput-dir=todo_output\nreports=HTML" }

    before do
      expect(File).to receive(:file?).with('.todo_buster').at_least(:once).and_return(true)
      expect(File).to receive(:open).with('.todo_buster').at_least(:once).and_return(StringIO.new(config_file))
      TodoBuster.configure
    end

    after do
      TodoBuster.configuration = nil
      TodoBuster.configure
    end

    it 'should be configured correctly' do
      expect(TodoBuster.configuration.valid_period).to eql 1.minute
      expect(TodoBuster.configuration.output_dir).to eql 'todo_output'
      expect(TodoBuster.configuration.reporters).to include('HTML')
      expect(TodoBuster.configuration.reporters).not_to include('CONSOLE')
    end
  end
end
