require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/wholesaler')

# INDEX
get '/wholesalers' do
  @wholesalers = Wholesaler.all()
  erb(:"wholesalers/index")
end

# NEW
get '/wholesalers/new' do
  erb(:"wholesalers/new")
end

# CREATE
post '/wholesalers' do
  @wholesaler = Wholesaler.new(params)
  @wholesaler.save
  redirect to '/wholesalers'
end

#SHOW
get '/wholesalers/:id' do
  @wholesaler = Wholesaler.find_by_id(params['id'])
  erb(:"wholesalers/show")
end
