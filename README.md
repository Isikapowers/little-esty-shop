# Little Esty Shop

## Table of contents
* [Description](#description)
* [Learning Goals](#learning-goals)
* [Requirements](#requirements)
* [Database Schema](#database-schema)
* [Phases](#phases)
* [Setup](#setup)
* [Live App](#live-app)
* [Tools Used](#tools-used)
* [Contributors](#contributors)

## Description

"Little Esty Shop" is a group project to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships.
- Practice loading csv files to the database.
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced ActiveRecord techniques to perform complex database queries.
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code.

## Requirements
- Rails 5.2.x
- PostgreSQL
- Test all feature and model code
- GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- Deploy completed code to Heroku

## Database Schema
![Schema](https://user-images.githubusercontent.com/72399033/134418403-99e1a24c-11fb-442c-a682-01e86095ba7d.png)

## Setup
This project requires Ruby 2.7.2.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle install`
    * `rails db:{create,migrate}`
    * `rails csv_load:all`
* Run the test suite with `bundle exec rspec`.
* Run `rails dev:cache` for API caching.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Evaluation](./doc/evaluation.md)

## Live App
[Link to Heroku deployment](https://little-esty-shop-denver.herokuapp.com)

## Tools Used

| Development    |  Testing             |
| :-------------:| :-------------------:|
| Ruby 2.7.2     | SimpleCov            |
| Rails 5.2.6    | Pry                  |
| HTML5          | Capybara             |
| Bootstrap      | ShouldaMatcher       |
| Atom           | Launchy              |
| Git            | Orderly              |
| Github         | Factorybot/Faker     |
| Github Project | Faraday              |
| Postico        | RSpec                |
| Heroku         |                      |

## Contributors

- [Isika Powers](https://github.com/Isikapowers/)
- [Ida Olson](https://github.com/idaolson)
- [Mike "Ozzie" Osmonson](https://github.com/ozzman84)
- [Rowan DeLong](https://github.com/RowanDW)
