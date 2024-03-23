defmodule MyAppWeb.Schema do
  use Absinthe.Schema

  import_types(MyAppWeb.Types.NoteTypes)
  import_types(MyAppWeb.Schema.NoteSchema)

  query do
    import_fields(:note_queries)
  end

  mutation do
    import_fields(:note_mutations)
  end
end
