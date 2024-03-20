defmodule MyAppWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string

    field :author, :user do
      resolve(fn post, _, _ ->
        {:ok, MyApp.Accounts.find_user(post.author_id)}
      end)
    end

    field :published_at, :naive_datetime
  end
end
