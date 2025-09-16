class WebhooksController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  skip_before_action :verify_authenticity_token
  skip_after_action :verify_authorized

  def receive
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError => e
      render json: { error: "JSON inválido: #{e.message}" }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      render json: { error: "Assinatura inválida: #{e.message}" }, status: 400
      return
    end

    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']
      user = User.find_by(id: session['client_reference_id'])

      if user && user.profile.present?
        user.profile.steps += 1000
        user.profile.save
      else
        Rails.logger.error("Webhook Error: User or profile not found for ID #{session['client_reference_id']}")
      end
    end

    render json: { message: 'Webhook processado com sucesso' }, status: :ok
  end
end
