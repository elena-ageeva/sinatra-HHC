require_relative '../../config/environment'
class ApplicationController<Sinatra::Base
  configure do
   set :views, Proc.new { File.join(root, "../views/") }
   enable :sessions unless test?
   set :session_secret, "secret"
 end

 helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end
end