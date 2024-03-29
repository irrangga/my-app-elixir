defmodule MyAppWeb.Schema.NoteSchema do
  use Absinthe.Schema.Notation

  alias MyAppWeb.Resolvers.NoteResolver

  object :note_queries do
    @desc "Get all notes"
    field :list_notes, list_of(:note) do
      resolve(&NoteResolver.list_notes/2)
    end

    @desc "Get note"
    field :get_note, :note do
      arg(:title, non_null(:string))

      resolve(&NoteResolver.get_note/2)
    end
  end

  object :note_mutations do
    @desc "Insert a note"
    field :insert_note, :string do
      arg(:title, non_null(:string))
      arg(:body, non_null(:string))

      resolve(&NoteResolver.insert_note/2)
    end

    @desc "Update a note"
    field :update_note, :string do
      arg(:title, non_null(:string))
      arg(:body, non_null(:string))

      resolve(&NoteResolver.update_note/2)
    end

    @desc "Delete a note"
    field :delete_note, :string do
      arg(:title, non_null(:string))

      resolve(&NoteResolver.delete_note/2)
    end
  end
end
