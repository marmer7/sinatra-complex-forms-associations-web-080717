class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new
    @pet.name = params[:pet][:name]
    @pet.owner = Owner.find_by(id: params[:pet][:owner])
    if params[:pet][:owner].nil?
      @pet.owner = Owner.find_or_create_by(name: params[:owner_name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by(id: params[:id])
    erb :"/pets/edit"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find_by(id: params[:id])
    @pet.update(params[:pet])
    if params[:owner][:name].size > 0
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
