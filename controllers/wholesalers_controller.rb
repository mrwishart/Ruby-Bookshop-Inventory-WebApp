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
  params['name'] = "Blank" if params['name'] == ""
  @wholesaler = Wholesaler.new(params)
  @wholesaler.save
  redirect to '/wholesalers'
end

# EDIT

get '/wholesalers/:id/edit' do
  @wholesaler = Wholesaler.find_by_id(params['id'])
  if @wholesaler.nil?
    erb(:'not_found')
  else
    erb(:"wholesalers/edit")
  end
end

#UPDATE

post '/wholesalers/:id' do
  params['name'] = "Blank" if params['name'] == ""
  @wholesaler = Wholesaler.new(params)
  @wholesaler.update()
  redirect to '/wholesalers/' + @wholesaler.id.to_s
end

#SHOW
get '/wholesalers/:id' do
  @wholesaler = Wholesaler.find_by_id(params['id'])
  erb(:"wholesalers/show")
end

# DELETE

post '/wholesalers/:id/delete' do
  @wholesaler = Wholesaler.find_by_id(params['id'])
  if @wholesaler.nil?
    redirect to '/not_found'
  else
    @wholesaler.delete
    redirect to '/wholesalers'
  end
end
