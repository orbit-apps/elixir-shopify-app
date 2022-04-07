defmodule ShopifyAppWeb.Router do
  use ShopifyAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ShopifyAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :shop_admin do
    plug ShopifyAPI.Plugs.AdminAuthenticator, shopify_router_mount: "/shop"
    plug ShopifyAPI.Plugs.PutShopifyContentHeaders
  end

  pipeline :shop_admin_api do
    plug :accepts, ["json"]
    plug ShopifyAPI.Plugs.AuthShopSessionToken
  end

  scope "/", ShopifyAppWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/shop", ShopifyAPI do
    forward("/", Router)
  end

  scope "/shop_admin/:app", ShopifyAppWeb do
    pipe_through :browser
    pipe_through :shop_admin

    # get "/", ShopAdminController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShopifyAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ShopifyAppWeb.Telemetry
    end
  end
end
