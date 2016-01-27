require 'spec_helper'
require 'todo_buster/todo'

describe TodoBuster::Todo do
  subject { TodoBuster::Todo.new(line_number: 1, file_name: 'file.rb') }

  context 'accessors' do
    it { is_expected.to respond_to(:line_number) }
    it { is_expected.to respond_to(:file_name) }
    it { is_expected.to respond_to(:commit_time) }
    it { is_expected.to respond_to(:committer) }
  end

  context 'initialization' do
    it 'should initialize correctly' do
      expect(subject.line_number).to eql 1
      expect(subject.file_name).to eql 'file.rb'
    end
  end
end
