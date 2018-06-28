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
    @owner = Owner.find_by_id(params[:owner_id])
    @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    if @owner.nil?
      @owner = Owner.create(name: params[:owner_name])
      @pet = Pet.create(name: params[:pet_name], owner_id: @owner.id)
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    if params[:owner_name] == ""
      @pet.name = params[:pet_name]
      @pet.save
    else
      @pet.name = params[:pet_name]
      new_owner = Owner.create(name: params[:owner_name])
      @pet.owner = new_owner
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
