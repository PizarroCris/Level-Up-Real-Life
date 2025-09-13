# Ficheiro: db/seeds/99_development_data.rb

if Rails.env.development?
  puts "🌱 Creating sample data for the development environment..."

  puts "👤 Creating test user..."
  test_user = User.find_or_create_by!(email: 'player@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
  
  # Graças ao nosso callback, o perfil já foi criado.
  # Agora, apenas o atualizamos com os recursos iniciais.
  puts "💰 Giving initial resources to the profile..."
  test_user.profile.update!(
    username: 'PlayerOne', # Podes definir um username personalizado aqui
    level: 1,
    wood: 50000,
    stone: 50000,
    metal: 50000
  )
  
  # ... (o resto do teu código para criar edifícios continua igual) ...

else
  puts "⏩ Skipping creation of test data (not in development environment)."
end
