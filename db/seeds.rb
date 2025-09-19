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
  { name: "Plot 1", pos_x: 627, pos_y: 316 },
  { name: "Plot 2", pos_x: 882, pos_y: 350 },
  { name: "Plot 3", pos_x: 431, pos_y: 443 },
  { name: "Plot 4", pos_x: 499, pos_y: 247 },
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

# ============================================================================
# --- CRIAÇÃO DO MUNDO (PLOTS, JOGADORES, GUILDAS, MONSTROS) ---
# ============================================================================
puts "🗺️  Creating the World..."

# 1. GERAR A GRELHA DE PLOTS DO MAPA
puts "   -> Generating map plot grid..."
MapPlot.destroy_all
MAP_SIZE = 5000
PLOT_SPACING = 400
MARGIN = 200
(MARGIN..(MAP_SIZE - MARGIN)).step(PLOT_SPACING).each do |y|
  (MARGIN..(MAP_SIZE - MARGIN)).step(PLOT_SPACING).each do |x|
    MapPlot.find_or_create_by!(pos_x: x, pos_y: y)
  end
end
puts "      #{MapPlot.count} map plots created."

# 2. SELECIONAR PLOTS DISPONÍVEIS E EMBARALHÁ-LOS
available_plots = MapPlot.all.to_a.shuffle

# 3. CRIAR AS TUAS CONTAS ESPECÍFICAS
puts "   -> Creating specific user accounts..."
users_to_create = [
  { username: 'Pizarro', email: 'cristianopizarro@lewagon.com', password: 'Password1!' },
  { username: 'Yan',     email: 'yanbuxes@lewagon.com',     password: '123456' },
  { username: 'Caio',    email: 'caiofigueiredo@lewagon.com', password: '123456' }
]
users_to_create.each do |user_data|
  # Pega num plot aleatório da lista e remove-o para não ser reutilizado
  plot_for_user = available_plots.pop
  break unless plot_for_user # Para se os plots acabarem

  user = User.find_or_create_by!(email: user_data[:email]) { |u| u.password = user_data[:password] }
  user.profile.update!(
    username: user_data[:username],
    wood: 57456, stone: 57456, metal: 57456, steps: 28327,
    map_plot: plot_for_user # Atribui o plot
  )
  puts "      - User '#{user_data[:username]}' created."
end

# 4. CRIAR GUILDAS ADICIONAIS COM FAKER
puts "   -> Creating 10 additional Faker guilds..."
10.times do
  plot_for_guild = available_plots.pop
  break unless plot_for_guild

  leader_user = User.create!(email: Faker::Internet.unique.email, password: "password")
  leader_user.profile.update!(map_plot: plot_for_guild)

  guild = Guild.create!(
    name: Faker::Company.name.truncate(12, omission: ''),
    tag: Faker::Alphanumeric.unique.alpha(number: 4).upcase,
    leader: leader_user.profile
  )
  GuildMembership.create!(guild: guild, profile: leader_user.profile, role: :leader)
end

# 5. ESPALHAR MONSTROS NOS PLOTS RESTANTES
puts "   -> Spawning monsters on remaining plots..."
WorldMonster.destroy_all
monster_blueprints = [
  { name: 'Dragon',    base_hp: 500, base_level: 5 },
  { name: 'Orc',       base_hp: 150, base_level: 2 },
  { name: 'Barbarian', base_hp: 250, base_level: 3 }
]
NUMBER_OF_MONSTERS = 30

# Pega numa amostra aleatória dos plots que AINDA estão disponíveis
plots_for_monsters = available_plots.sample(NUMBER_OF_MONSTERS)

plots_for_monsters.each do |plot|
  blueprint = monster_blueprints.sample
  WorldMonster.create!(
    name: blueprint[:name],
    level: blueprint[:base_level],
    hp: blueprint[:base_hp],
    pos_x: plot.pos_x,
    pos_y: plot.pos_y
  )
end
puts "      #{WorldMonster.count} monsters spawned."
puts "✅ World creation complete."
puts "----------------------------------------"
puts "Seeding finished!"
