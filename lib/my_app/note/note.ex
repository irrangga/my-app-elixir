defmodule MyApp.Note do
  def list_notes() do
    case Redix.command(:redix, ["KEYS", "*"]) do
      {:ok, keys} ->
        keys
        |> Enum.map(fn key ->
          case get_note(key) do
            {:error, _error} -> :error
            note -> note
          end
        end)
        |> Enum.reject(fn note ->
          is_nil(note) || note == :error
        end)

      {:error, error} ->
        {:error, error}
    end
  end

  def get_note(title) do
    case Redix.command(:redix, ["GET", title]) do
      {:ok, nil} ->
        nil

      {:ok, body} ->
        %{
          title: title,
          body: body
        }

      {:error, error} ->
        {:error, error}
    end
  end

  def insert_note(title, body) do
    case Redix.command(:redix, ["SET", title, body]) do
      {:ok, _} ->
        "success"

      {:error, error} ->
        {:error, error}
    end
  end
end