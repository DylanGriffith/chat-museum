require 'cinch'

namespace :irc_listeners do

  desc "Start listener for IRC channnel with channel_id"
  task :start, [:channel_id] => :environment do |t, args|
    channel = Channel.find(args[:channel_id])
    bot = Cinch::Bot.new do
      configure do |c|
        c.server = channel.hostname
        c.channels = [channel.channel_name]
        c.ssl.use = true
        c.password = channel.password
        c.nicks = ["ChatMuseum", "TheChatMuseum"]
        c.port = channel.port
      end

      on :message do |message|
        Message.create(:channel => channel, :content => message.message, :author => message.user.nick)
      end
    end

    bot.start
  end

  desc "Start all listeners for IRC channnels"
  task start_all: :environment do
    Channel.pluck(:id).each do |channel_id|
      Rake::Task["irc_listeners:start"].invoke(channel_id)
    end
  end
end
