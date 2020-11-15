# CookingDiary

## Synopsis

### What is CookingDiary?

**CookingDiary** is Rails web application using (RestAPI) methods, where people can write their recipes, see others recipes with instructions which have orders and info also with ingridients.
This app is used while cooking, you need a good dinner check this web app for some delicios (food) recipes. You can check out different recipes ( in details ) also can post a recipe, can see others recipes etc..

## Contribution

**Refactoring code**, e.g. improving the code without modifying the behavior is an area that can probably be done based on intuition and may not require much communication to be merged.

**Fixing bugs** may also not require a lot of communication, but the more the better. Please surround bug fixes with ample tests. Bugs are magnets for other bugs. Write tests near bugs!

### How to Contribute

1. Fork the project & clone locally.
2. Create a branch, naming it contribute: git checkout -b contribute
3. Push to the branch: git push origin contribute
4. Create a pull request for your branch 🎉

Note: be sure to keep your fork in sync!

## Getting Started

### Setup

#### Requirements

Install these software first

* Ruby (recommended version => '2.7.2') - we recommend to use rbenv for installation
* Rails (recommended version '6.0.3' must be in '>= 6.0.3.2')
* SQLite3
* Bundler -v => '2.1.4 or higher'

### Installation

Once you clone this project from github or download it, make sure you run `update bundler` also after that `bundle install` to make sure every gem is successfully installed and ready to use.

### Starting the application

First thing you have to do is:
`rails db:migrate, rails db:create & rails db:seed` .
Or you can use `rails db:reset` and than use `rails db:seed`

Before running the server i recommend you tu run:
`rails routes` -> to see every possible route that you want to request.

After that you can start by typing in terminal: `rails server` -> to run the server ( check 'localhost:3000/routes')

- You might need to run `yarn install --check-files` if Yarn packages are out of date!


### Running tests

For testing i have user RSpec framework version `4.0.1`

To run all tests run:
`$ rspec` 

#### Nesseccary gems used for testing

*   gem 'rspec-rails', '~> 4.0.1'
*   gem 'factory_bot_rails' -> for creating factories ( model testing )
*   gem 'shoulda-matchers', '~> 4.0'   
*   gem 'rails-controller-testing'

## Bugs and Features Requests

Submit to https://github.com/gzim921/cooking_app/issues