$user = YAML.load_file("config/mine.yml")[Rails.env]
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
  	authenticate_or_request_with_http_basic do |username, password|
	    if(username == $user['name'] && password == $user['password'])
	      true
	    else
	      redirect_to root_path
	    end
  	end
	end
end
