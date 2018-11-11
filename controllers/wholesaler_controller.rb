require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/wholesaler')

#
get '/wholesaler' do
  @wholesalers = Wholesaler.all()
  erb(:"wholesaler/index")
end
