# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do
  band = Band.create(name: Faker::Team.name)

  rand(10).times do
    album = Album.create(
      band: band,
      name: Faker::Commerce.product_name,
      live_or_studio: Album::LIVE_OR_STUDIO.sample
    )

    (rand(5) + rand(5)).times do
      def lyrics
        lyrics = ""
        rand(20).times { lyrics += Faker::Lorem.words(rand(5)).join(" ") + "\n" }
        lyrics.gsub(/[\n]+/, "\n")
      end

      Track.create(
        album: album,
        name: Faker::Company.catch_phrase,
        bonus_or_regular: Track::BONUS_OR_REGULAR.sample,
        lyrics: lyrics
      )
    end
  end






end
