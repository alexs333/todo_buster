require 'spec_helper'
require 'todo_buster/configurators/file_masks_configurator'

describe TodoBuster::Configurators::FileMasksConfigurator do
  before { TodoBuster.configure }

  context 'valid configuration' do
    it 'should apply the configuration correctly' do
      expect{ subject.apply_config('*.ts, *.erb') }.to change{ TodoBuster.configuration.file_masks }.to(%w(*.ts *.erb))
    end
  end

  context 'invalid configuration' do
    it 'should output the error message end exit' do
      expect(STDOUT).to receive(:puts).with('Invalid file mask')
      expect{ subject.apply_config(',,,') }.to raise_exception(SystemExit)
    end
  end
end
