require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')
