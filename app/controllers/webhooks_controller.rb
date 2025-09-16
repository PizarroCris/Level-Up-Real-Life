# app/controllers/webhooks_controller.rb
class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  
  def receive
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError => e
      # Lida com um payload inválido
      render json: { error: "JSON inválido: #{e.message}" }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Lida com uma assinatura inválida
      render json: { error: "Assinatura inválida: #{e.message}" }, status: 400
      return
    end

    # Processa o evento apenas se for uma sessão de checkout concluída
    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']

      # Encontra o usuário pelo ID que passamos para o Stripe
      user = User.find_by(id: session['client_reference_id'])

      # Verifica se o usuário e o perfil existem antes de atualizar
      if user && user.profile.present?
        # Adiciona 1000 passos ao perfil do usuário
        user.profile.steps += 1000
        user.profile.save
      else
        # Loga um erro se o usuário ou o perfil não for encontrado
        Rails.logger.error("Webhook Error: User or profile not found for ID #{user_id}")
      end
    end

    # Retorna uma resposta de sucesso para o Stripe
    render json: { message: 'Webhook processado com sucesso' }, status: :ok
  end
end
