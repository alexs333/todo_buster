require 'spec_helper'
require 'todo_buster/todo'
require 'active_support/all'
require 'todo_buster/configuration'
require 'todo_buster/reporters/html_reporter'

describe TodoBuster::Reporters::HtmlReporter do
  include FakeFS::SpecHelpers

  let(:todo) { TodoBuster::Todo.new(line_number: 1, file_name: 'file.rb') }
  let(:file) { double 'file' }

  before do
    TodoBuster.configure
    todo.committer = 'test_user'
  end

  after do
    reporter.generate
  end

  describe 'report generation' do
    context 'when results are found' do
      let(:reporter) { described_class.new([todo]) }

      it 'should generate report that contains results' do
        expect(Dir).to receive(:mkdir).with('todo_reports')
        expect(File).to receive(:open).with('todo_reports/todo_report.html', 'w').and_yield(file)
        expect(file).to receive(:write).with /test_user/
      end
    end

    context 'when no results' do
      let(:reporter) { described_class.new([]) }

      it 'should write a report that indicates that no violations had been found' do
        expect(Dir).to receive(:mkdir).with('todo_reports')
        expect(File).to receive(:open).with('todo_reports/todo_report.html', 'w').and_yield(file)
        expect(file).to receive(:write).with /No TODO violations had been found/
      end
    end
  end
end
