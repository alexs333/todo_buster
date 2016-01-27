require 'spec_helper'
require 'todo_buster/finder'

describe TodoBuster::Finder do
  describe 'finding all TODOs' do
    let(:finder) { TodoBuster::Finder.new }
    let(:data) { "test\n#TODO: never\ntest\n" }

    before do
      expect(Dir).to receive(:glob).with(/\*\*\/\*.rb/).and_return %w(file1.rb)
      expect(finder).to receive(:open).with('file1.rb').and_return StringIO.new(data)
      @todos = finder.send :find_all_todos
    end

    it 'should find a toodo' do
      expect(@todos.size).to eql 1
      expect(@todos.first.line_number).to eql 2
      expect(@todos.first.file_name).to eql 'file1.rb'
    end
  end

  describe 'parsing git blame output' do
    let(:raw_blame_output_part) do
      '''
      committer testUser
      committer-mail <test@test.com>
      committer-time 1452475175
      committer-tz +1100
      '''
    end
    let(:formatted_blame_output) { TodoBuster::Finder.new.send(:parse_blame_output, raw_blame_output_part) }

    it 'should be a hash' do
      expect(formatted_blame_output.class).to be Hash
    end

    it 'should have a time in a hash' do
      expect(formatted_blame_output['committer-time']).to eql '1452475175'
    end

    it 'should have a committer in hash' do
      expect(formatted_blame_output['committer']).to eql 'testUser'
    end
  end

  describe 'displaying search results' do
    before do
      todo = TodoBuster::Todo.new line_number: 1, file_name: 'file.rb'
      todo.committer = 'test_user'
      @todos = [todo]
    end

    it 'should print to console' do
      expect(STDOUT).to receive(:puts).with /1.*file.rb.*test_user/
      TodoBuster::Finder.new.send :print_violations, @todos
    end
  end
end
