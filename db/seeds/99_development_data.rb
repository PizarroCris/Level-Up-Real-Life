# ==============================================================================
# SAMPLE DATA FOR DEVELOPMENT
# ==============================================================================

if Rails.env.development?
  puts "🌱 Creating sample data for the development environment..."

  puts "👤 Creating test user and profile..."
  test_user = User.create!(
    email: 'player@example.com',
    password: 'password'
  )
  test_profile = Profile.create!(
    user: test_user,
    username: 'PlayerOne',
    level: 1,
    wood: 5000,
    stone: 5000,
    metal: 2500
  )
  # ==========================================================

  puts "🏗️ Building one of each available building type for testing..."

  # Apanhar 5 lotes diferentes para colocar as construções
  plot1 = Plot.find_by(name: "Plot 1")
  plot2 = Plot.find_by(name: "Plot 2")
  plot3 = Plot.find_by(name: "Plot 3")
  plot4 = Plot.find_by(name: "Plot 4")
  plot5 = Plot.find_by(name: "Plot 5")

  Building.create!(profile: test_profile, plot: plot1, building_type: 'castle', level: 3)
  Building.create!(profile: test_profile, plot: plot2, building_type: 'barrack', level: 1)
  Building.create!(profile: test_profile, plot: plot3, building_type: 'sawmill', level: 2)
  Building.create!(profile: test_profile, plot: plot4, building_type: 'quarry', level: 2)
  Building.create!(profile: test_profile, plot: plot5, building_type: 'mine', level: 1)


  puts "✅ #{Building.count} sample buildings created successfully."
  puts "   Test Login: player@example.com | password"
else
  puts "⏩ Skipping creation of test data (not in development environment)."
end

puts "----------------------------------------"
puts "🎉 Seeding finished!"
puts "----------------------------------------"
