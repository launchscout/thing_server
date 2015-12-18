# ThingServer

This is the server side of a simple proof of concept angular2 Phoenix app. It
serves up the api and sends updates over Phoenix channels. You'll need to run the
[client side app](https://github.com/gaslight/things) as well.

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Start Phoenix endpoint with `mix phoenix.server`
