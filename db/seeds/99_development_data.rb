# Este ficheiro cria dados de exemplo APENAS em ambiente de desenvolvimento.

# --- 1. LIMPEZA ---
# Primeiro, limpamos tudo para garantir que começamos do zero.
puts "🧹 Cleaning development database..."
GuildMembership.destroy_all
Guild.destroy_all
Building.destroy_all # Adicionado para uma limpeza completa
Profile.destroy_all
User.destroy_all
puts "✅ Development database cleaned."

# --- 2. CRIAÇÃO DO UTILIZADOR PRINCIPAL DE TESTE ---
if Rails.env.development?
  puts "🌱 Creating sample data for the development environment..."

  puts "👤 Creating main test user..."
  main_user = User.find_or_create_by!(email: 'player@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
  
  # O callback 'after_create' no modelo User já criou o perfil.
  # Agora, apenas o atualizamos com recursos e um username personalizado.
  puts "💰 Giving initial resources to the main profile..."
  main_user.profile.update!(
    username: 'PlayerOne',
    level: 1,
    wood: 50000,
    stone: 50000,
    metal: 50000
  )
  puts "   Test Login: player@example.com | password"

  # --- 3. CRIAÇÃO DE GUILDAS ADICIONAIS (COM FAKER) ---
  puts "🏰 Creating 15 additional guilds with Faker..."
  15.times do |i|
    # Cria um utilizador. O perfil é criado automaticamente pelo callback.
    guild_leader_user = User.create!(
      email: Faker::Internet.unique.email,
      password: "password"
    )

    # A guilda precisa de um líder (que é um Profile).
    leader_profile = guild_leader_user.profile

    # Cria a guilda, garantindo que o nome não excede o limite de validação.
    guild = Guild.create!(
      name: Faker::Company.name.truncate(12, omission: ''), # Trunca para 12 chars
      tag: Faker::Alphanumeric.unique.alpha(number: 4).upcase,
      description: Faker::Lorem.sentence(word_count: 5),
      leader: leader_profile
    )

    # Cria a adesão para o líder.
    GuildMembership.create!(
      guild: guild,
      profile: leader_profile,
      role: :leader
    )
  end
  puts "✅ #{Guild.count} total guilds created!"

else
  puts "⏩ Skipping creation of test data (not in development environment)."
end
