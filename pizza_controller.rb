require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('./models/pizza.rb')

# INDEX (READ - index all the routes)
get '/pizzas' do
  @pizzas = Pizza.all() # the @ makes pizzas available everywhere.
  erb(:index)
end

# NEW (CREATE - user needs to get the form)
# This route must be above get '/pizzas/:id' --> CORRECT ORDER!
get '/pizzas/new' do
  erb(:new)
end

# SHOW (READ - show us just one pizza (find by ID))
get '/pizzas/:id' do
  @pizza = Pizza.find(params[:id])
  erb(:show)
end

# CREATE (CREATE - user needs to submit the form)
post '/pizzas' do
  @pizza = Pizza.new(params)
  @pizza.save
  erb(:create)
end

# EDIT (UPDATE - create form)
get '/pizzas/:id/edit' do
  @pizza = Pizza.find(params[:id])
  erb(:edit)
end

# UPDATE (UPDATE - submit form)
post '/pizzas/:id' do
  pizza = Pizza.new(params)
  pizza.update
  redirect to "pizzas/#{pizza.id}"
end

# DESTROY (DELETE)
post '/pizzas/:id/delete' do
  pizza = Pizza.find(params[:id])
  pizza.delete
  redirect to '/pizzas'
end
