# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}.jpg"))
end

@identified = Categories.find_or_create_by(name: "identified")
@unidentified = Categories.find_or_create_by(name: "unidentified")
@larld = User.find_or_create_by(username:"larld", password: "ayosafepwhere", admin: 0 )
@admin = User.find_or_create_by(username:"admin", password: "adminpassword", admin: 1 )
@kooldude = User.find_or_create_by(username:"kooldude132", password: "134koolpass", admin: 0 )
@avery = User.find_or_create_by(username:"AverySpeaks", password: "speakeasyavery", admin: 0 )
@angelfish = Fish.find_or_create_by(title: "fish from carribean", content: "I saw this fish while scuba diving in the Carribean, I have no idea what it could be at all.", fish_image: seed_image('angelfish'), user: @larld)
@clownfish = Fish.find_or_create_by(title: "possible clownfish", content: "I almost know for a fact this is a clownfish, I just would like an expert to confirm this for me.", fish_image: seed_image('clownfish'), user: @kooldude)
@porgy = Fish.find_or_create_by(title: "caught while fishing", content: "This was caught one day while fishing off the coast of Mass. U.S.", fish_image: seed_image('porgy'), user: @avery)

