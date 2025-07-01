# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
if Rails.env.development?
  admin = User.find_by(username: 'admin')

  if admin
    puts "Admin user already exists"
  else
    User.create!(
      username: 'admin',
      password: 'admin123',
      password_confirmation: 'admin123',
      role: 'admin'
    )
    puts "Admin user created successfully!"
  end
else
  puts "Skipping admin user creation (not in development)"
end

