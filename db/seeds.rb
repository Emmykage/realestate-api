# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = User.create(first_name: 'jon', last_name: 'doe', password: 'chemistry', phone_no: '07064334160', role: 'admin',
                    email: 'jondoe@gmail.com')
