defmodule ShopifyApp.Workflow.AppUninstall do
  @type t() :: %__MODULE__{myshopify_domain: String.t()}
  @enforce_keys [:myshopify_domain]
  defstruct @enforce_keys

  @spec call(t()) :: :ok
  def call(%{myshopify_domain: myshopify_domain} = context) when is_struct(context, __MODULE__) do
    {:ok, _} = myshopify_domain |> ShopifyApp.Shops.find() |> ShopifyApp.Shops.delete()
    :ok = ShopifyAPI.ShopServer.delete(myshopify_domain)
    :ok = ShopifyAPI.AuthTokenServer.delete(myshopify_domain, ShopifyApp.Config.app_name())
    :ok = ShopifyAPI.UserTokenServer.delete_for_shop(myshopify_domain)
  end

  @spec new(Keyword.t()) :: t()
  def new(params), do: struct(__MODULE__, params)
end
