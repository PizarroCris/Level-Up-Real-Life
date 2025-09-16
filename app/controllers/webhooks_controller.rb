class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError => e
      # Payload inválido
      render json: { error: e.message }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Assinatura inválida
      render json: { error: e.message }, status: 400
      return
    end

    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']

      user_id = session['client_reference_id']
      user = User.find(user_id)
      # Adiciona os passos ao perfil do usuário
      user.profile.steps += 1000 # 1000 passos para cada compra, por exemplo
      user.profile.save
    end
    render json: { message: 'Success' }, status: :ok
  end
end
