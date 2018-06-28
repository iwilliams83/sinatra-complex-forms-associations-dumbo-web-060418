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
    puts "HEEEY I'm in the post! Params: #{params}"
    redirect to "pets/#{@pet.id}"
  end
end
