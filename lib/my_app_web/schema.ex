defmodule MyAppWeb.Schema do
  use Absinthe.Schema

  import_types(MyAppWeb.Schema.NoteTypes)

  alias MyAppWeb.Resolvers

  query do
    @desc "Get all notes"
    field :list_notes, list_of(:note) do
      resolve(&Resolvers.Note.list_notes/2)
    end

    @desc "Get note"
    field :get_note, :note do
      arg(:title, non_null(:string))

      resolve(&Resolvers.Note.get_note/2)
    end
  end

  mutation do
    @desc "Taking a note"
    field :insert_note, :string do
      arg(:title, non_null(:string))
      arg(:body, non_null(:string))

      resolve(&Resolvers.Note.insert_note/2)
    end
  end
end
