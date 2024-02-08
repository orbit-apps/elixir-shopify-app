defmodule ShopifyApp.GraphQLLoader do
  @doc """
  GraphQLLoader provides macros for compile time loading of GraphQL queries from files,
  and recompile the module using the file if the graphql file changes. The directory
  can be passed in on use via the :dir or :directory option. Upon calls to the `load_query_file/1`
  macro it will throw a compile time exception if the file is missing.

  example:

  ```elixir
  defmodule MyApp.GraphQLQuery do
    use ShopifyApp.GraphQLLoader, dir: "graphql_directory"

    @query load_query_file("some_query.graphql")
    def do_query do
      GraphQLLib.query(@query)
    end
  end
  ```

  And create the graphql file in `graphql_directory/some_query.graphql`.
  """

  defmacro __using__(opts) do
    quote do
      graph_ql_dir = Keyword.get(unquote(opts), :dir) || Keyword.get(unquote(opts), :directory)

      unless is_nil(graph_ql_dir) do
        Module.put_attribute(__MODULE__, :graph_ql_directory, Path.join(__DIR__, graph_ql_dir))
      end

      import ShopifyApp.GraphQLLoader
    end
  end

  defmacro graph_ql_directory(dir) do
    quote do
      Module.put_attribute(__MODULE__, :graph_ql_directory, Path.join(__DIR__, unquote(dir)))
    end
  end

  defmacro load_query_file(file) do
    quote do
      graphql_file =
        if Module.has_attribute?(__MODULE__, :graph_ql_directory),
          do: Path.join(Module.get_attribute(__MODULE__, :graph_ql_directory), unquote(file)),
          else: Path.join(__DIR__, unquote(file))

      Module.put_attribute(__MODULE__, :external_resource, graphql_file)
      File.read!(graphql_file)
    end
  end
end
