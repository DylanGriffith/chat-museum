require 'rails_helper'

RSpec.describe Message, :type => :model do
  context '#trigram_search' do
    before(:each) do
      Message.create!(:author => "me", :content => "hello world")
      Message.create!(:author => "someone", :content => "hello frank")
      Message.create!(:author => "someone_else", :content => "goodbye bob")
      Message.create!(:author => "someone_else", :content => "jumping jack")
      Message.create!(:author => "someone_else", :content => "jack jumped")
      Message.create!(:author => "someone_else", :content => "jack jumps")
    end

    it 'finds messages with matching content' do
      match = Message.trigram_search("hello")
      expect(match.to_a.count).to eq(2)
    end

    it 'stems words' do
      match = Message.trigram_search("jumping")
      expect(match.to_a.count).to eq(3)
    end
  end
end
