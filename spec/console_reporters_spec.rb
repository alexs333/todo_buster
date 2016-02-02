require 'spec_helper'
require 'todo_buster/todo'
require 'todo_buster/reporters/console_reporter'

describe TodoBuster::Reporters::ConsoleReporter do
  let(:todo) { TodoBuster::Todo.new(line_number: 1, file_name: 'file.rb') }

  before { todo.committer = 'test_user' }
  after { reporter.generate }

  describe 'report generation' do
    context 'when results are found' do
      let(:reporter) { described_class.new([todo]) }

      it 'should print results to the console' do
        expect(STDOUT).to receive(:puts).with /1.*file.rb.*test_user/
      end
    end

    context 'when no results' do
      let(:reporter) { described_class.new([]) }

      it 'should print "not found" message to the console' do
        expect(STDOUT).to receive(:puts).with 'No TODO violations had been found'
      end
    end
  end
end
