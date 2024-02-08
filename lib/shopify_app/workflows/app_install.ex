defmodule ShopifyApp.Workflow.AppInstall do
  require Logger

  alias ShopifyApp.Worker.Install.CreateWebhook

  @type t() :: %__MODULE__{myshopify_domain: String.t()}
  @enforce_keys [:myshopify_domain]
  defstruct @enforce_keys

  @spec call(t()) :: :ok
  def call(%{myshopify_domain: myshopify_domain} = context) when is_struct(context, __MODULE__) do
    Enum.each(ShopifyApp.Config.shop_webhooks(), &CreateWebhook.enqueue(myshopify_domain, &1))

    Logger.debug("New install", myshopify_domain: myshopify_domain)
    :ok
  end

  @spec new(Keyword.t()) :: t()
  def new(params), do: struct(__MODULE__, params)
end
