require 'spec_helper'
require 'todo_buster/configurators/output_dir_configurator'

describe TodoBuster::Configurators::OutputDirConfigurator do
  before { TodoBuster.configure }

  it 'should configure output directory' do
    expect{ subject.apply_config('artifacts') }.to change{ TodoBuster.configuration.output_dir }.from('todo_reports').to('artifacts')
  end
end
