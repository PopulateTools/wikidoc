class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsManagement
  helper_method :current_user, :logged_in?, :current_user?, :login_path
  
  protected

    def profile_owner
      @user = params[:id] ? User.find(params[:id]) : current_user

      redirect_to(root_path) unless @user == current_user
    end

    def external_service_unauthorized
      flash[:error] = t('.unauthorized')
      redirect_to root_path
    end

    def modal_error(flash_type, message)
      flash[:modal_error] = flash_type
      flash["modal_#{flash_type}_error".to_sym] = message
    end

    def login_path
      root_path(anchor: 'login')
    end  
end
