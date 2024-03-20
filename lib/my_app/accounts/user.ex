defmodule MyApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias MyApp.Content

  schema "users" do
    field :name, :string
    field :password_hash, :string

    has_many :posts, Content.Post, foreign_key: :author_id

    timestamps()
  end

  @doc false
  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  @doc false
  def changeset(%__MODULE__{} = user, attrs) do
    attrs =
      attrs
      |> Map.put(:password_hash, Argon2.hash_pwd_salt(attrs.password))

    user
    |> cast(attrs, [:name, :password_hash])
    |> validate_required([:name, :password_hash])
  end
end
