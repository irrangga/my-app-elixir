defmodule MyAppWeb.Resolvers.Content do
  def list_posts(%MyApp.Accounts.User{} = author, args, _resolution) do
    {:ok, MyApp.Content.list_posts(author, args)}
  end

  def list_posts(_parent, _args, _resolution) do
    {:ok, MyApp.Content.list_posts()}
  end
end
