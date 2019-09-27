class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def basic_auth

  	user = User.find_by(email: request.headers['HTTP_X_USER_EMAIL'])
  	#tiene permisos si existe el usuario y coinciden los tokens:
  	#byebug
  	if user && request.headers['X-API-TOKEN'] === user.api_token
  		permission = true
  	else
  		permission = false
  	end

  	unless permission
  		render json: { errors: "You don't have permissions" }, status: 401
  	end

  end
end
