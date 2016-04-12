require 'spec_helper'
require 'todo_buster/configurators/valid_period_configurator'

describe TodoBuster::Configurators::ValidPeriodConfigurator do
  before { TodoBuster.configure }

  context 'valid configuration' do
    it 'should reconfigure validity period' do
      expect{ subject.apply_config('1.year') }.to change{ TodoBuster.configuration.valid_period }.from(1.month).to(1.year)
    end
  end

  context 'invalid configuration' do
    it 'should output the error message end exit' do
      expect(STDOUT).to receive(:puts).with('Invalid validity period')
      expect{ subject.apply_config('1.lightyear') }.to raise_exception(SystemExit)
    end
  end
end
