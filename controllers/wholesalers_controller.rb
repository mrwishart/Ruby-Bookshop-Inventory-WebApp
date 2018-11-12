require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/wholesaler')

# INDEX
get '/wholesalers' do
  @wholesalers = Wholesaler.all()
  erb(:"wholesalers/index")
end

#SHOW
get '/wholesalers/:id' do
  @wholesaler = Wholesaler.find_by_id(params['id'])
  erb(:"wholesalers/show")
end
