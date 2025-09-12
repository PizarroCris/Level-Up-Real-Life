# Este ficheiro é o ponto de entrada. Ele vai carregar todos os outros
# ficheiros de seed que estão na pasta db/seeds/.

puts "----------------------------------------"
puts "🚀 Starting the master seeding process..."

# Procura todos os ficheiros .rb na pasta db/seeds,
# ordena-os por nome (graças aos números 01_, 02_), e executa-os.
Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end

puts "🎉 Master seeding process finished!"
puts "----------------------------------------"
