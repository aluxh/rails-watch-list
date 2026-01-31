# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'

# Clean the database
Movie.destroy_all

url = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1"
bearer_token = "Bearer #{ENV['TMDB_API_KEY']}"

response = URI.open(url, "Authorization" => bearer_token, "accept" => "application/json")
data = JSON.parse(response.read)
movies = data["results"]

# puts movies.length

# Create the database
movies.each do |movie_data|
  Movie.create!(
    title: movie_data["title"],
    overview: movie_data["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_data['poster_path']}",
    rating: movie_data["vote_average"]
  )
end
