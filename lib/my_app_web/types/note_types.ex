defmodule MyAppWeb.Types.NoteTypes do
  use Absinthe.Schema.Notation

  object :note do
    field(:title, :string)
    field(:body, :string)
  end
end
