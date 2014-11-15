require 'rails_helper'

RSpec.describe Message, :type => :model do
  context 'searching' do
    before(:each) do
      Message.create!(:author => "me", :content => "hello world")
      Message.create!(:author => "someone", :content => "hello frank")
      Message.create!(:author => "someone_else", :content => "goodbye bob")
    end

    it 'finds messages with matching content' do
      match = Message.search("hello world").count
      expect(match.count).to eq(2)
    end
  end
end
