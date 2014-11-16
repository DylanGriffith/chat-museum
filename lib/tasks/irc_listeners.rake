require 'cinch'

namespace :irc_listeners do

  desc "Start listener for IRC server with server_id"
  task :start, [:server_id] => :environment do |t, args|
    server = Server.find(args[:server_id])
    p server
    bot = Cinch::Bot.new do
      configure do |c|
        c.server = server.hostname
        c.channels = [server.channel_name]
        c.ssl.use = server.use_ssl?
        c.password = server.password
        c.nicks = ["ChatMuseum", "TheChatMuseum"]
        c.port = server.port
      end

      on :message do |message|
        Message.create(:server => server, :content => message.message, :author => message.user.nick)
      end
    end

    bot.start
  end

  desc "Start all listeners for IRC servers"
  task start_all: :environment do
    Server.pluck(:id).each do |server_id|
      Rake::Task["irc_listeners:start"].invoke(server_id)
    end
  end
end
