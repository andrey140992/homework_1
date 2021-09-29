require "./allReports"
require 'sinatra'

#report = AllReports.new("./csv/vms.csv", "./csv/prices.csv", "./csv/volumes.csv", "10")



set :bind, '0.0.0.0'
set :port, 4567

get '/' do
    return "hello world!"
end

get '/reports' do
  report = AllReports.new("./csv/vms.csv", "./csv/prices.csv", "./csv/volumes.csv", "10")
  return report.highest_price
end

get '/say/*/to/*' do
  # matches /say/hello/to/world
  params['splat'] # => ["hello", "world"]
end
