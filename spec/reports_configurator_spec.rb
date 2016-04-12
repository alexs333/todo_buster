require 'spec_helper'
require 'todo_buster/configurators/reports_configurator'

describe TodoBuster::Configurators::ReportsConfigurator do
  before { TodoBuster.configure }

  context 'valid configuration' do
    before do
      subject.apply_config 'CONSOLE,HTML'
    end

    it 'should apply configuration correctly' do
      expect(TodoBuster.configuration.reporters).to include('CONSOLE')
      expect(TodoBuster.configuration.reporters).to include('HTML')
    end
  end

  context 'invalid configuration' do
    it 'should output the error message end exit' do
      expect(STDOUT).to receive(:puts).with('Invalid report, valid options are: CONSOLE or/and HTML')
      expect{ subject.apply_config('XML') }.to raise_exception(SystemExit)
    end
  end
end
