require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('./controllers/authors_controller')
require_relative('./controllers/books_controller')
require_relative('./controllers/genres_controller')
require_relative('./controllers/wholesalers_controller')

# Index

get '/' do
  redirect to '/books'
end

error 404 do
  erb(:'404')
end
