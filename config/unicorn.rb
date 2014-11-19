app_path = "/home/museum/chat-museum"

# use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.
worker_processes 2

# run the app as an unprivileged user.
user "museum"

working_directory app_path

# listen on a unix domain socket or a tcp port.
# we use a shorter backlog for quicker failover when busy.
listen "#{app_path}/tmp/sockets/unicorn.sock", :backlog => 64
#listen 8080, :tcp_nopush => true

# nuke workers after 30 seconds instead of 60 seconds (the default).
timeout 30

# feel free to point this anywhere accessible on the filesystem.
pid "#{app_path}/tmp/pids/unicorn.pid"

# by default, the unicorn logger will write to stderr.
# additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path "#{app_path}/log/unicorn.stderr.log"
stdout_path "#{app_path}/log/unicorn.stdout.log"

# combine ree with "preload_app true" for memory savings.
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
gc.respond_to?(:copy_on_write_friendly=) and
  gc.copy_on_write_friendly = true

before_fork do |server, worker|

  # the following is highly recomended for rails + "preload_app true"
  # as there's no need for the master process to hold a connection.
  defined?(activerecord::base) and
    activerecord::base.connection.disconnect!

  # this allows a new master process to incrementally
  # phase out the old master process with sigttou to avoid a
  # thundering herd (especially in the "preload_app false" case)
  # when doing a transparent upgrade.  the last worker spawned
  # will then kill off the old master process with a sigquit.
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :quit : :ttou
      process.kill(sig, file.read(old_pid).to_i)
    rescue errno::enoent, errno::esrch
    end
  end
end

after_fork do |server, worker|

  # the following is *required* for rails + "preload_app true",
  defined?(activerecord::base) and
    activerecord::base.establish_connection

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as memcached,
  # and redis.
end
