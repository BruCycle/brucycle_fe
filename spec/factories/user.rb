FactoryBot.define do
  factory :user do
    strava_id { 62 }
    username { Faker::Movies::StarWars.unique.character }
    firstname { Faker::Name.unique.first_name  }
    lastname { Faker::Name.last_name }
    photo_url { "https://dgalywyr863hv.cloudfront.net/pictures/athletes/112175675/26236812/1/large.jpg" }
  end
end