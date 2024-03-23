defmodule MyApp.Note do
  alias MyApp.Redix

  def list_notes() do
    case Redix.command(["KEYS", "*"]) do
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
    case Redix.command(["GET", title]) do
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
    case get_note(title) do
      {:error, error} ->
        {:error, error}

      nil ->
        case Redix.command(["SET", title, body]) do
          {:ok, _} ->
            "success"

          {:error, error} ->
            {:error, error}
        end

      _ ->
        {:error, "Note already exist"}
    end
  end

  def update_note(title, body) do
    case get_note(title) do
      {:error, error} ->
        {:error, error}

      nil ->
        {:error, "No notes found"}

      _ ->
        case Redix.command(["SET", title, body]) do
          {:ok, _} ->
            "success"

          {:error, error} ->
            {:error, error}
        end
    end
  end

  def delete_note(title) do
    case Redix.command(["DEL", title]) do
      {:ok, 1} ->
        "success"

      {:ok, 0} ->
        {:error, "No notes found"}

      {:error, error} ->
        {:error, error}
    end
  end
end
