# Responsabilidade: Criar dados essenciais para o jogo funcionar.

# --- 1. PLOTS ---
puts "🏞️ Creating Plots with pixel coordinates..."
# As coordenadas são em pixels, baseadas numa imagem de 1280x720
plots_data = [
  { name: "Plot 1", pos_x: 640, pos_y: 360 }, # Centro exato
  { name: "Plot 2", pos_x: 960, pos_y: 250 }, # Canto superior direito
  { name: "Plot 3", pos_x: 320, pos_y: 500 }, # Canto inferior esquerdo
  { name: "Plot 4", pos_x: 250, pos_y: 200 }, # Canto superior esquerdo
  { name: "Plot 5", pos_x: 1050, pos_y: 550 } # Canto inferior direito
]

plots_data.each do |data|
  Plot.find_or_create_by!(name: data[:name]) do |plot|
    plot.pos_x = data[:pos_x]
    plot.pos_y = data[:pos_y]
  end
end
puts "✅ #{Plot.count} plots are in place."

# --- 2. EQUIPMENT CATALOG ---
puts "📚 Creating equipment item catalog..."

# ============================================================================
# --- BARBARIAN SET (Attack-focused) ---
# ============================================================================
puts "Creating Barbarian Set..."
EquipmentItem.create!([
  { name: "Barbarian Helmet",    equipment_type: "helmet",    attack: 5,  defense: 10, speed_bonus: 2, price_in_steps: 1200 },
  { name: "Barbarian Armor",     equipment_type: "armor",     attack: 10, defense: 20, speed_bonus: 0, price_in_steps: 2500 },
  { name: "Barbarian Gauntlets", equipment_type: "gauntlet",  attack: 8,  defense: 5,  speed_bonus: 1, price_in_steps: 1000 },
  { name: "Barbarian Boots",     equipment_type: "boots",     attack: 2,  defense: 5,  speed_bonus: 5, price_in_steps: 1500 },
  { name: "Barbarian Axe",       equipment_type: "sword",     attack: 25, defense: -5, speed_bonus: 0, price_in_steps: 3000 },
  { name: "Barbarian Totem",     equipment_type: "accessory", attack: 10, defense: 0,  speed_bonus: 2, price_in_steps: 2800 }
])

# ============================================================================
# --- CHAMPION SET (Defense-focused) ---
# ============================================================================
puts "Creating Champion Set..."
EquipmentItem.create!([
  { name: "Champion Helmet",    equipment_type: "helmet",    attack: 5,  defense: 20, speed_bonus: 0, price_in_steps: 1500 },
  { name: "Champion Armor",     equipment_type: "armor",     attack: 5,  defense: 40, speed_bonus: -2, price_in_steps: 3000 },
  { name: "Champion Gauntlets", equipment_type: "gauntlet",  attack: 10, defense: 15, speed_bonus: 0, price_in_steps: 1200 },
  { name: "Champion Boots",     equipment_type: "boots",     attack: 0,  defense: 10, speed_bonus: 2, price_in_steps: 1000 },
  { name: "Champion Sword",     equipment_type: "sword",     attack: 15, defense: 10, speed_bonus: 0, price_in_steps: 2800 },
  { name: "Champion Ring",    equipment_type: "accessory", attack: 5,  defense: 15, speed_bonus: 0, price_in_steps: 2600 }
])

# ============================================================================
# --- MAGICIAN SET (Speed-focused) ---
# ============================================================================
puts "Creating Magician Set..."
EquipmentItem.create!([
  { name: "Magician Hat",      equipment_type: "helmet",    attack: 2, defense: 5,  speed_bonus: 8, price_in_steps: 2000 },
  { name: "Magician Robes",    equipment_type: "armor",     attack: 0, defense: 10, speed_bonus: 10, price_in_steps: 2800 },
  { name: "Magician Gloves",   equipment_type: "gauntlet",  attack: 5, defense: 2,  speed_bonus: 5, price_in_steps: 1500 },
  { name: "Magician Shoes",    equipment_type: "boots",     attack: 0, defense: 2,  speed_bonus: 12, price_in_steps: 2200 },
  { name: "Magician Wand",    equipment_type: "sword",     attack: 8, defense: 0,  speed_bonus: 5, price_in_steps: 2500 },
  { name: "Magician Talisman", equipment_type: "accessory", attack: 2, defense: 2,  speed_bonus: 15, price_in_steps: 3200 }
])

# ============================================================================
# --- ORC SET (High-risk, high-reward) ---
# ============================================================================
puts "Creating Orc Set..."
EquipmentItem.create!([
  { name: "Orc Helmet",    equipment_type: "helmet",    attack: 8,  defense: 15, speed_bonus: -5, price_in_steps: 1800 },
  { name: "Orc Armor",     equipment_type: "armor",     attack: 15, defense: 35, speed_bonus: -10, price_in_steps: 3500 },
  { name: "Orc Gauntlets", equipment_type: "gauntlet",  attack: 12, defense: 10, speed_bonus: -2, price_in_steps: 1600 },
  { name: "Orc Boots",     equipment_type: "boots",     attack: 5,  defense: 8,  speed_bonus: -8, price_in_steps: 1400 },
  { name: "Orc Cleaver",   equipment_type: "sword",     attack: 35, defense: 5,  speed_bonus: -5, price_in_steps: 4000 },
  { name: "Orc Necklace", equipment_type: "accessory", attack: 15, defense: 5,  speed_bonus: -5, price_in_steps: 2900 }
])

# ============================================================================
# --- SPECIAL ACCESSORY (Reward Item) ---
# ============================================================================
puts "Creating Special Accessory..."
EquipmentItem.create!(
  name: "Amulet of the Fitness",
  equipment_type: "accessory",
  attack: 0,
  defense: 0,
  speed_bonus: 30,
  price_in_steps: 0
)

puts "✅ #{EquipmentItem.count} equipment items created."
