class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization
  before_action :regenerate_user_energy

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def after_sign_in_path_for(resource)
    user_base_path
  end

 def ensure_profile!
    return if current_user.profile.present?
    available_plot = MapPlot.find_by(profile: nil)
    
    if available_plot
      current_user.create_profile!(
        username: current_user.email.split("@").first,
        map_plot: available_plot
      )
    else
      flash[:alert] = "No available plots. Please try again later."
      redirect_to root_path
    end
  end

  def regenerate_user_energy
    current_user&.profile&.regenerate_energy
  end
end
