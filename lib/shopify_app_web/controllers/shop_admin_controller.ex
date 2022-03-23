defmodule ShopifyAppWeb.ShopAdminController do
  use ShopifyAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
