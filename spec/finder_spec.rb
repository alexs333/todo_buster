require 'spec_helper'
require 'todo_buster/finder'

describe TodoBuster::Finder do
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
  end
end
