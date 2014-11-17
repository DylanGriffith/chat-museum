rails_root = "/home/museum/chat-museum"
irc_pid_file = "#{rails_root}/tmp/pids/irc-listeners.pid"

God.watch do |w|
  # The name of the process.
  # You can then use it with god commands such as start/stop/restart.
  w.name = "irc-listeners"

  # Use the process group if you want to start/stop/restart multiple processes at once.
  w.group = "chat-museum"

  # Environment variables to set before starting the process.
  w.env = { 'RAILS_ENV' => 'production' }

  # Working directory where commands will be run.
  w.dir = rails_root

  # Where unicorn stores its PID file. God uses this to track the process.
  w.pid_file = irc_pid_file

  # Clean stale PID files before starting.
  w.behavior :clean_pid_file

  w.start = "rake irc_listeners:start_all"

  w.log = "#{rails_root}/tmp/logs/irc_listeners.log"
end
