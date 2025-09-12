# Responsabilidade: Limpar a base de dados na ordem correta.

puts "🧹 Cleaning the database..."

# A ordem é importante para evitar erros de dependência.
# Começamos pelos modelos que "pertencem a" outros.
Equipment.destroy_all
Building.destroy_all
Profile.destroy_all
User.destroy_all
Plot.destroy_all
EquipmentItem.destroy_all # O teu catálogo de itens

puts "✅ Database cleaned."
