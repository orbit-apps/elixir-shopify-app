defmodule ShopifyApp.Repo do
  use Ecto.Repo,
    otp_app: :shopify_app,
    adapter: Ecto.Adapters.Postgres

  @doc """
  A macro to define a set of standard types for our Schemas.

  Use like so:
  ```elixir
  defmodule ShopifyApp.SomeModels do
    use ShopifyApp.Repo, define_types: ShopifyApp.Schema.SomeModel.t()
  end
  ```
  """
  def define_types(base_type) do
    quote do
      @type t() :: unquote(base_type)
      @type t_or_nil() :: t() | nil
      @type ok_t() :: {:ok, t()}
      @type ok_changeset_error() :: ok_t() | {:error, Ecto.Changeset.t(t())}
      @type ok_error_not_found() :: ok_t() | {:error, :not_found}
      @type ok_errors() :: ok_t() | {:error, Ecto.Changeset.t(t())} | {:error, :not_found}
    end
  end

  @type record :: record
  @spec ok_or_not_found(nil) :: {:error, :not_found}
  @spec ok_or_not_found(record) :: {:ok, record}
  def ok_or_not_found(nil), do: {:error, :not_found}
  def ok_or_not_found(record), do: {:ok, record}

  @doc """
  dispatch to define_types passing through the scheme models type
  """
  defmacro __using__([{:define_types, base_type}]), do: define_types(base_type)
end
