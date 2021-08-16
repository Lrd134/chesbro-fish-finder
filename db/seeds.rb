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
users = {
  :larld => {
    username: "larld",
    password: "ayosafepwhere",
    admin: 0
  },
  :admin => {
    username: "admin",
    password: "adminpassword",
    admin: 1
  },
  :avery => {
    username: "AverySpeaks",
    password: "speakeasyavery",
    admin: 0
  },
  :kooldude => {
    username: "kooldude132",
    password: "134koolpass",
    admin: 0
  },
  :fishpert => {
    username: "FishFindingExpert",
    password: "expertinfishdontguessme",
    admin: 1
  }
  
}
@identified = Category.find_or_create_by(name: "identified")
@unidentified = Category.find_or_create_by(name: "unidentified")
@larld = User.seed_by_hash(users[:larld])
@admin = User.seed_by_hash(users[:admin])
@avery = User.seed_by_hash(users[:avery])
@fishpert = User.seed_by_hash(users[:fishpert])
@kooldude = User.seed_by_hash(users[:kooldude])
@angelfish = Fish.find_or_create_by(title: "fish from carribean", content: "I saw this fish while scuba diving in the Carribean, I have no idea what it could be at all.", user: @larld)
@angelfish.fish_image.attach(io: seed_image('angelfish'), filename: 'angelfish.jpg', content_type: 'application/jpg')
@clownfish = Fish.find_or_create_by(title: "possible clownfish", content: "I almost know for a fact this is a clownfish, I just would like an expert to confirm this for me.", user: @kooldude)
@clownfish.fish_image.attach(io: seed_image('clownfish'), filename: 'clownfish.jpg', content_type: 'application/jpg')
@porgy = Fish.find_or_create_by(title: "caught while fishing", content: "This was caught one day while fishing off the coast of Mass. U.S.", user: @avery)
@porgy.fish_image.attach(io: seed_image('porgy'), filename: 'porgy.jpg', content_type: 'application/jpg')
Comment.find_or_create_by(body: "That fish totally looks like some type of angelfish, I'm not sure exactly which one though!", user: @avery, fish: @angelfish)
Comment.find_or_create_by(body: "This is a clownfish. You were correct.", user: @larld, fish: @clownfish)
Comment.find_or_create_by(body: "I have no idea what this could be", user: @kooldude, fish: @porgy )
Comment.find_or_create_by(body: "This looks very intersting, I know this is a common type of fish.", user: @fishpert, fish: @porgy)

