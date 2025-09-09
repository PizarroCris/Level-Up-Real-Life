class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[show edit update destroy]
  after_action :verify_authorized

  def index
    @profiles = policy_scope(Profile)
  end

  def show
    authorize @profile
  end

  def new
    @profile = Profile.new
    authorize @profile
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    authorize @profile

    if @profile.save
      redirect_to @profile, notice: "Profile created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @profile
  end

  def update
    authorize @profile
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @profile
    @profile.destroy
    redirect_to profiles_path, notice: "Profile deleted successfully."
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:username)
  end
end
