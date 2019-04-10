defmodule ShopifyAppWeb.Router do
  use ShopifyAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    # This sets X-Frame-Options and that won't work with shopify
    # plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :shop_admin do
    plug ShopifyAPI.Plugs.AdminAuthenticator
  end

  scope "/", ShopifyAppWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/shop", ShopifyAPI do
    forward("/", Router)
  end

  scope "/shop-admin/:app", ShopifyAppWeb do
    pipe_through :browser
    pipe_through :shop_admin
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShopifyAppWeb do
  #   pipe_through :api
  # end
end
