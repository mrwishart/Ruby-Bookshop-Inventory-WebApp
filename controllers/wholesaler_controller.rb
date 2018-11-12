require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/wholesaler')

# INDEX
get '/wholesaler' do
  @wholesalers = Wholesaler.all()
  erb(:"wholesaler/index")
end

#SHOW
get '/wholesaler/:id' do
  @wholesaler = Wholesaler.find_by_id(params['id'])
  erb(:"wholesaler/show")
end
