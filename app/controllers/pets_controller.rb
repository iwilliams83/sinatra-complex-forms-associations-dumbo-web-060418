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
    @owner = Owner.find(params[:owner_id])
    if @owner.nil?
      @owner = Owner.create(name: params[owner_name])
    end

    @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    puts "I'm a pet: #{@pet}"
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
