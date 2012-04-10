require File.expand_path("shotgun", File.dirname(__FILE__))
require File.expand_path("settings", File.dirname(__FILE__))

class Application < Nancy::Base
  include Rack::Utils
  use Rack::CommonLogger, File.open("log/#{ENV['RACK_ENV']}.log")
  use Rack::MethodOverride
  use Rack::Static, root: "public", urls: ["/javascripts", "/stylesheets", "/images"]
  use Rack::Session::Cookie, key: "__app__", secret: "__secret__"
  use Rack::Protection
  use Rack::Protection::RemoteReferrer
end

Dir["./lib/**/*.rb"].each { |rb| require rb }
Dir["./models/**/*.rb"].each { |rb| require rb }
Dir["./controllers/**/*.rb"].each { |rb| require rb }
