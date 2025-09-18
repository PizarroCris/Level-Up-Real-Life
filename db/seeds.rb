puts "----------------------------------------"
puts "🧹 Limpando a base de dados..."
GuildMembership.destroy_all
Guild.destroy_all
Building.destroy_all
Troop.destroy_all
Equipment.destroy_all
Profile.destroy_all
User.destroy_all
Plot.destroy_all
MapPlot.destroy_all
WorldMonster.destroy_all
EquipmentItem.destroy_all
puts "✅ Base de dados limpa."
puts "----------------------------------------"

# --- 1. DADOS ESSENCIAIS (CATÁLOGO DE ITENS) ---
puts "📚 A criar catálogo de equipamentos..."
EquipmentItem.create!([
  { name: "Barbarian Helmet", equipment_type: "helmet", attack: 5, defense: 10, speed_bonus: 2, price_in_steps: 1200 },
  { name: "Barbarian Armor", equipment_type: "armor", attack: 10, defense: 20, speed_bonus: 0, price_in_steps: 2500 },
  { name: "Barbarian Gauntlets", equipment_type: "gauntlet", attack: 8, defense: 5, speed_bonus: 1, price_in_steps: 1000 },
  { name: "Barbarian Boots", equipment_type: "boots", attack: 2, defense: 5, speed_bonus: 5, price_in_steps: 1500 },
  { name: "Barbarian Axe", equipment_type: "sword", attack: 25, defense: -5, speed_bonus: 0, price_in_steps: 3000 },
  { name: "Barbarian Totem", equipment_type: "accessory", attack: 10, defense: 0, speed_bonus: 2, price_in_steps: 2800 },
  { name: "Champion Helmet", equipment_type: "helmet", attack: 5, defense: 20, speed_bonus: 0, price_in_steps: 1500 },
  { name: "Champion Armor", equipment_type: "armor", attack: 5, defense: 40, speed_bonus: -2, price_in_steps: 3000 },
  { name: "Champion Gauntlets", equipment_type: "gauntlet", attack: 10, defense: 15, speed_bonus: 0, price_in_steps: 1200 },
  { name: "Champion Boots", equipment_type: "boots", attack: 0, defense: 10, speed_bonus: 2, price_in_steps: 1000 },
  { name: "Champion Sword", equipment_type: "sword", attack: 15, defense: 10, speed_bonus: 0, price_in_steps: 2800 },
  { name: "Champion Ring", equipment_type: "accessory", attack: 5, defense: 15, speed_bonus: 0, price_in_steps: 2600 },
  { name: "Magician Hat", equipment_type: "helmet", attack: 2, defense: 5, speed_bonus: 8, price_in_steps: 2000 },
  { name: "Magician Robes", equipment_type: "armor", attack: 0, defense: 10, speed_bonus: 10, price_in_steps: 2800 },
  { name: "Magician Gloves", equipment_type: "gauntlet", attack: 5, defense: 2, speed_bonus: 5, price_in_steps: 1500 },
  { name: "Magician Shoes", equipment_type: "boots", attack: 0, defense: 2, speed_bonus: 12, price_in_steps: 2200 },
  { name: "Magician Wand", equipment_type: "sword", attack: 8, defense: 0, speed_bonus: 5, price_in_steps: 2500 },
  { name: "Magician Talisman", equipment_type: "accessory", attack: 2, defense: 2, speed_bonus: 15, price_in_steps: 3200 },
  { name: "Orc Helmet", equipment_type: "helmet", attack: 8, defense: 15, speed_bonus: -5, price_in_steps: 1800 },
  { name: "Orc Armor", equipment_type: "armor", attack: 15, defense: 35, speed_bonus: -10, price_in_steps: 3500 },
  { name: "Orc Gauntlets", equipment_type: "gauntlet", attack: 12, defense: 10, speed_bonus: -2, price_in_steps: 1600 },
  { name: "Orc Boots", equipment_type: "boots", attack: 5, defense: 8, speed_bonus: -8, price_in_steps: 1400 },
  { name: "Orc Cleaver", equipment_type: "sword", attack: 35, defense: 5, speed_bonus: -5, price_in_steps: 4000 },
  { name: "Orc Necklace", equipment_type: "accessory", attack: 15, defense: 5, speed_bonus: -5, price_in_steps: 2900 },
  { name: "Fitness Amulet", equipment_type: "accessory", attack: 0, defense: 0, speed_bonus: 30, price_in_steps: 0 }
])
puts "✅ #{EquipmentItem.count} equipamentos criados."

puts "----------------------------------------"

# --- 2. PLOTS DA BASE INTERNA ---
puts "🏞️ A criar os plots da base interna..."
plots_data = [
  { name: "Plot 1", pos_x: 595, pos_y: 253 },
  { name: "Plot 2", pos_x: 886, pos_y: 332 },
  { name: "Plot 3", pos_x: 457, pos_y: 404 },
  { name: "Plot 4", pos_x: 500, pos_y: 240 },
  { name: "Plot 5", pos_x: 661, pos_y: 460 }
]

plots_data.each do |data|
  Plot.find_or_create_by!(name: data[:name]) do |plot|
    plot.pos_x = data[:pos_x]
    plot.pos_y = data[:pos_y]
  end
end
puts "✅ #{Plot.count} plots da base interna criados."

puts "----------------------------------------"

# --- 3. PLOTS DO MAPA-MÚNDI ---
puts "🗺️ A criar os plots do mapa em grelha..."
map_width = 1920
map_height = 1080
plot_spacing_x = 450
plot_spacing_y = 450
(plot_spacing_y..(map_height - plot_spacing_y)).step(plot_spacing_y).each do |y|
  (plot_spacing_x..(map_width - plot_spacing_x)).step(plot_spacing_x).each do |x|
    MapPlot.find_or_create_by!(pos_x: x, pos_y: y)
  end
end
puts "✅ #{MapPlot.count} map plots was created."

puts "----------------------------------------"

puts "👹 Cleaning up old monsters..."
WorldMonster.destroy_all

puts "👹 Creating a variety of monsters across the map..."

# 1. Define os "modelos" dos nossos tipos de monstros
monster_blueprints = [
  { name: 'Dragon',    base_hp: 500, base_level: 5 },
  { name: 'Orc',       base_hp: 150, base_level: 2 },
  { name: 'Barbarian', base_hp: 250, base_level: 3 },
]

# 2. Define os limites do mapa (com base no teu CSS) e quantos monstros queremos
MAP_WIDTH = 5000
MAP_HEIGHT = 5000
NUMBER_OF_MONSTERS = 50

# 3. Guarda todos os locais já ocupados (por castelos de jogadores) para não
#    colocar um monstro em cima de um jogador.
occupied_spots = Profile.joins(:map_plot).pluck('map_plots.pos_x', 'map_plots.pos_y')

# 4. O loop de criação
NUMBER_OF_MONSTERS.times do
  # Encontra um local vazio no mapa
  random_x, random_y = 0, 0
  loop do
    # Gera coordenadas aleatórias dentro do mapa (com uma margem das bordas)
    random_x = rand(100..MAP_WIDTH - 100)
    random_y = rand(100..MAP_HEIGHT - 100)

    # Se o local não estiver ocupado, sai do loop e usa estas coordenadas
    break unless occupied_spots.include?([random_x, random_y])
  end

  # Adiciona o novo local à lista de locais ocupados para a próxima iteração
  occupied_spots << [random_x, random_y]

  # Escolhe um tipo de monstro aleatório da nossa lista de modelos
  blueprint = monster_blueprints.sample

  # Cria o monstro com os dados aleatórios e do modelo
  WorldMonster.create!(
    name: blueprint[:name],
    level: blueprint[:base_level] + rand(-1..1), # Nível base com pequena variação
    hp: blueprint[:base_hp] * (blueprint[:base_level] + rand(0..2)), # HP com variação
    pos_x: random_x,
    pos_y: random_y
  )
end

puts "✅ #{WorldMonster.count} monstros criados em locais aleatórios."

# --- 5. DADOS DE DESENVOLVIMENTO (UTILIZADORES E GUILDAS) ---
if Rails.env.development?
  puts "🌱 A criar dados de exemplo para o ambiente de desenvolvimento..."

  # ✅ REFINEMENT: Get all available plot IDs ONCE before the loop.
  available_plot_ids = MapPlot.pluck(:id) - Profile.pluck(:map_plot_id)

  puts "👤 A criar utilizador principal de teste..."
  if available_plot_ids.any?
    main_user = User.find_or_create_by!(email: 'player@example.com') do |user|
      user.password = 'password'
    end

    # ✅ REFINEMENT: Let the User callback create the profile, then update it.
    main_user.profile.update!(
      username: 'PlayerOne',
      level: 1,
      wood: 50000,
      stone: 50000,
      metal: 50000,
      map_plot_id: available_plot_ids.shift # Use and remove the first available ID
    )
    puts "   Login de Teste: player@example.com | password"
  else
    puts "⚠️ Não há plots de mapa disponíveis para o utilizador principal."
  end

  puts "----------------------------------------"

  puts "🏰 A criar 15 guildas adicionais com o Faker..."
  15.times do |i|
    break if available_plot_ids.empty? # Stop if we run out of plots

    # ✅ REFINEMENT: Let the User callback create the profile.
    guild_leader_user = User.create!(
      email: Faker::Internet.unique.email,
      password: "password"
    )
    leader_profile = guild_leader_user.profile
    leader_profile.update!(map_plot_id: available_plot_ids.shift) # Assign a plot

    guild = Guild.create!(
      name: Faker::Company.name.truncate(12, omission: ''),
      tag: Faker::Alphanumeric.unique.alpha(number: 4).upcase,
      description: Faker::Lorem.sentence(word_count: 5),
      leader: leader_profile
    )
    GuildMembership.create!(
      guild: guild,
      profile: leader_profile,
      role: :leader
    )
  end
  puts "✅ #{Guild.count} guildas criadas!"

else
  puts "⏩ A ignorar a criação de dados de teste (não em ambiente de desenvolvimento)."
end
