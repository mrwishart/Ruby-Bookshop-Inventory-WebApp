require('sinatra')
require('sinatra/contrib/all') if development?
# also_reload('./models/*')

require_relative('./controllers/authors_controller')
require_relative('./controllers/books_controller')
require_relative('./controllers/bookauthors_controller')
require_relative('./controllers/bookgenres_controller')
require_relative('./controllers/genres_controller')
require_relative('./controllers/wholesalers_controller')
require_relative('./models/CSSHelper')

# Index

get '/' do
  redirect to '/books'
end

error 404 do
  erb(:'404')
end
