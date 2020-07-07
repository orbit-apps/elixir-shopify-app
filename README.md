## Elixir Shopify App

Everyting you need to get [Elixir Shopify API](https://github.com/pixelunion/elixir-shopifyapi) up and running.

## Usage

1. Clone this project `git clone https://github.com/pixelunion/elixir-shopify-app.git`
1. Rename the directory to a new project name `mv elixir-shopify-app your_project_name`
1. Delete the internal Git directory `rm -rf .git`
1. Run the boilerplate setup script `./boilerplate-setup.sh YourProjectName`
1. Create a new Git repository `git init`
1. Create the initial Git commit `git commit -a -m "Initial commit"`
1. Setup a Shopify App
  - Add the api key and secret to you're `.env`
  - Update the whitelisted urls to include `https://public-facing-url.ngrok.com/shop/authenticed/your_project_name`
1. Start your database `docker-compose up -d`
1. Fetch depenancies
  - `mix deps.get`
  - `mix ecto.setup`
  - `cd assets && yarn install && cd ..`
1. Start your app `mix phx.server` or `iex -S mix phx.server`
1. Initiate install via `localhost:4000/shop/install?app=new_app_name&shop=mydevshop.myshopify.com`

## Credits

Boilerplate idea and install script borrowed from [Mirego](https://github.com/mirego/elixir-boilerplate)
