defmodule MyAppWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  alias MyAppWeb.Resolvers

  @desc "A user of the blog"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string

    field :posts, list_of(:post) do
      arg(:date, :date)
      resolve(&Resolvers.Content.list_posts/3)
    end
  end
end
