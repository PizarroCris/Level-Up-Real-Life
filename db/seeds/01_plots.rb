puts "----------------------------------------"
puts "🚀 Starting the seeding process..."

# First, clean the database in the correct order to avoid foreign key errors.
# Models that depend on others must be destroyed first.
puts "🧹 Cleaning the database..."
Equipment.destroy_all # Add this line
Building.destroy_all
Profile.destroy_all
User.destroy_all
Plot.destroy_all

# ==============================================================================
# PART 1: CORE APPLICATION DATA (REQUIRED FOR THE GAME TO WORK)
# ==============================================================================
puts "🏞️ Creating core Plots..."
plots_data = [
  { name: "Plot 1", top_percent: 50.5, left_percent: 48.0 },
  { name: "Plot 2", top_percent: 30.0, left_percent: 75.0 },
  { name: "Plot 3", top_percent: 80.0, left_percent: 25.0 },
  { name: "Plot 4", top_percent: 40.0, left_percent: 20.0 },
  { name: "Plot 5", top_percent: 65.0, left_percent: 80.0 }
]

plots_data.each_with_index do |data, index|
  Plot.create!(name: "Plot #{index + 1}", top_percent: data[:top_percent], left_percent: data[:left_percent])
end

puts "✅ #{Plot.count} core plots created successfully."
puts "----------------------------------------"
