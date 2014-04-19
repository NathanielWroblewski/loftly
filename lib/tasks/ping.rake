desc 'Pings site url to keep dyno alive'

task :ping do
  require 'net/http'

  uri = URI(ENV['APPLICATION_HOMEPAGE'])
  Net::HTTP.get_response(uri)
end
