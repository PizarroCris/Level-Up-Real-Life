class GlobalMessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @global_message = GlobalMessage.new(message_params)
    @global_message.profile = current_user.profile
    authorize @global_message
    
    respond_to do |format|
      if @global_message.save
        format.turbo_stream
      else
        format.html { redirect_to user_base_path, alert: "Message could not be sent." }
      end
    end
  end

  private

  def message_params
    params.require(:global_message).permit(:content)
  end
end
