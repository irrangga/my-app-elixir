defmodule MyAppWeb.Resolvers.NoteResolver do
  def list_notes(_args, _resolution) do
    case MyApp.Note.list_notes() do
      {:error, error} -> {:error, error}
      notes -> {:ok, notes}
    end
  end

  def get_note(%{title: title}, _resolution) do
    case MyApp.Note.get_note(title) do
      {:error, error} -> {:error, error}
      note -> {:ok, note}
    end
  end

  def insert_note(%{title: title, body: body}, _resolution) do
    case MyApp.Note.insert_note(title, body) do
      {:error, error} -> {:error, error}
      _ -> {:ok, "success"}
    end
  end
end
