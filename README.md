# Alien Translator

Alien Translator fullstack application. Using this application English is turned into an alien language known as Gorbyoyo. Using mulitple API endpoints a translation from English to Gorbyoyo is reached and displayed on screen, saving your translations.

## Set Up

This App is made using Ruby on Rails, if you do not have Rails installed, install Rails using: 
```
gem install rails
```
Otherwise to reproduce the App on your machine follow these steps:

1. When you clone the repository and enter your editor, go to the command line and install the gems needed to run the App. To do this enter:

```
bundle install
```

2. Next to migrate the database and have translations saved, in the command line enter:

```
rails db:migrate
```

3. The server will run on http://localhost:3000/ after running the server. To start the server run:

```
rails s
```

4. Finally to see tests used in App, in the command line enter:

```
rspec
```