User.create!(name:  "Admin User",
             email: "hienmv94@gmail.com",
             password:              "mrhien1994",
             password_confirmation: "mrhien1994",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do |n|
  title = "Demo- #{n+1}"
  content = Faker::Lorem.sentence(5)
  comment = "This is Demo"
  users.each { |user| user.entries.create!(title: title, content: content)}
end
# users = User.last(6)
# 50.times do |n|
#   content = "This is comment"
#   users.each {|user| user.comments.create!(content: content, entry_id: n)}
# end


# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
User.create!(name:  "Demo User",
             email: "hienmv.nd@gmail.com",
             password:              "mrhien1994",
             password_confirmation: "mrhien1994",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)