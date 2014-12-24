class SessionsController < Devise::SessionsController
  
  skip_before_filter :require_login, :only => [:new, :create]
  
  def new
    super
  end
  
  def create
    self.resource = warden.authenticate!(auth_options)

    if self.resource.active?
      # sign_in(resource_name, self.resource)
      yield resource if block_given?
      # Agent.login_user(self.resource.id)
      redirect_to root_url, :notice => "Logged in!"
    elsif self.resource.inactive?
      redirect_to log_in_url, :flash => { :notice => "Deactivated user" }
    else
      redirect_to log_in_path, :flash => { :notice => "Invalid email or password" }
    end
  end
  
  def destroy

    # create a logout agent event for the user
    # Agent.logout_user(current_user.id)

    super
  end
  
  protected
  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end
end