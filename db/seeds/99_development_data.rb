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


# Limpa as tabelas para evitar duplicados
puts "Cleaning database..."
GuildMembership.destroy_all
Guild.destroy_all
Profile.destroy_all
User.destroy_all

puts "Creating guilds..."

15.times do |i|
  # Cria um utilizador e um perfil para cada guilda
  user = User.create!(
    email: "test#{i}@example.com",
    password: "password",
    admin: false
  )

  profile = Profile.create!(
    user: user,
    username: Faker::Internet.username(specifier: 5..10),
    # ... outros atributos do perfil, se houver
  )

  # Creates the guild with a name that respects the 20-character limit
  guild = Guild.create!(
    name: Faker::Company.name.first(20), # Slices the name to a max of 20 characters
    tag: Faker::Alphanumeric.unique.alpha(number: 5).upcase,
    description: Faker::Lorem.sentence(word_count: 10),
    leader: profile,
    max_members: 50
  )

  # Adiciona o líder à guilda como um membro com a role 'leader'
  GuildMembership.create!(
    guild: guild,
    profile: profile,
    role: :leader
  )
end

puts "Database seeded successfully with 15 guilds!"
