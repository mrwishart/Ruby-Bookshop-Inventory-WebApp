require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/author')

# INDEX

get '/author' do
  @authors = Author.all()
  erb(:"author/index")
end

# NEW

get '/author/new' do
  erb(:"author/new")
end

# CREATE

post '/author' do
  Author.new(params).save
  redirect to '/author'
end

# SHOW

get '/author/:id' do
  @author = Author.find_by_id(params['id'])
  if @author.nil?
    erb(:'404')
  else
    erb(:'author/show')
  end
end

# EDIT

get '/author/:id/edit' do
  @author = Author.find_by_id(params['id'])
  if @author.nil?
    erb(:'404')
  else
    erb(:'author/edit')
  end
end

# UPDATE

post '/author/:id' do
  @author = Author.new(params)
  @author.update
  redirect to '/author/' + @author.id.to_s
end

# DELETE

post '/author/:id/delete' do
  @author = Author.find_by_id(params['id'])
  if @author.nil?
    redirect to '/404'
  else
    @author.delete
    redirect to '/author'
  end
end
