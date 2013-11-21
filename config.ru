# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)

if ENV["RACK_ENV"] == "development" || ENV["RACK_ENV"] == "test"
  # integrate MM for easier development
  ENV["PALAVA_RTC_ADDRESS"] ||= 'ws://127.0.0.1:4233'
  ENV["PALAVA_PORTAL_DIR"]  ||= '../portal'
  ENV["MM_ROOT"]            ||= File.dirname(__FILE__) + '/' + ENV["PALAVA_PORTAL_DIR"]
  run lambda{ |env|
    if env['PATH_INFO'] =~ %r<\A/($|favicon.ico$|assets|html|images)>
      Middleman.server.call(env)
    else
      PalavaHq::Application.call(env)
    end
  }
else
  run PalavaHq::Application
end
