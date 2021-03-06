require_relative '../lib/postal/config'
threads_count = Postal.config.web_server&.max_threads&.to_i || 5
threads         threads_count, threads_count
bind_address  = Postal.config.web_server&.bind_address || '127.0.0.1'
bind_port     = Postal.config.web_server&.port&.to_i || 5000
bind            "tcp://#{bind_address}:#{bind_port}"
environment     Postal.config.rails&.environment || 'development'
prune_bundler
quiet false
unless ENV['LOG_TO_STDOUT']
  stdout_redirect Postal.app_root.join('log', 'puma.log'), Postal.app_root.join('log', 'puma.log'), true
end

if ENV['APP_ROOT']
  directory ENV['APP_ROOT']
end
