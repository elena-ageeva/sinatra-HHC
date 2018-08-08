require 'rack-flash'
class NursesController<ApplicationController
  use Rack::Flash
 get '/new' do
   erb :'nurses/new'
 end

 get '/patients' do
   #binding.pry
   @nurse=Nurse.find_by(id: current_user.id)
   if @nurse
     erb :'nurses/show'
   else
     erb :'nurses/new'
   end
 end

 post '/new' do
   @nurse=Nurse.find_or_create_by(first_name: params[:first_name], last_name: params[:last_name])
   erb:'nurses/show'
 end

 get '/nurses/:slug/edit'do
  @user=Nurse.find_by(id: current_user.id)
  @nurse=Nurse.find_by_slug(params[:slug])
  #binding.pry
  if @nurse
    if @user.id!=@nurse.id
      message="You are not authorized to edit #{@nurse.name}."
      @nurse=@user
    else
      message=""
    end
   else
     message="Link does not exist."
     @nurse=@user
    end
    flash[:message]=message
    erb :'nurses/edit'
    #flash[:message]=message

 end

 post '/nurses/:slug' do
   #binding.pry
   @nurse=Nurse.find_by_slug(params[:slug])
   if @nurse
     @nurse.update(params[:nurse])
     #@patient.save
     flash[:message]="Successfully updated nurse #{@nurse.name}"
     erb :'/nurses/show'

   else
     erb :'error'
   end

 end

end
