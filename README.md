# Recommend

A social-media-like app but for recommendations, where you can see other people's recommendations, may it be a book, movie, or a game. A user can recommend other user's recommendation, recommend another brand but with the same category, or recommend their own brand with a different category. This app looks to bring a single platform where you can search for a category(eg. restaurant) you would like to try and what other people's favorite brand(eg. Cheesecake Factory) it has to offer.

## Using Heroku

To use this app go to https://shaq-recommend.herokuapp.com/

or install to your local environment:

## Installation

Clone this repo to your terminal.

Then cd into the project folder.

Then run bundle to install necessary dependencies

	$ bundle install

## Usage

After bundling, we have to set up the database and run the app to our local host.

Step 1 - Run in the terminal: `rails db:migrate` to setup database tables. <br>
Step 2 - Run in the terminal: `rails db:seed` to populate existing data from the repo <br>
Step 3 - Run in the terminal: `rails s` to start rails server <br>
Step 4 - Navigate to http://localhost:3000 on your browser to start the app.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shaquille-galimba/ReCommend. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The app is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
