defmodule MyAppWeb.Note.Queries.DeleteNoteTest do
  use MyAppWeb.ConnCase

  alias MyApp.Redix
  alias MyAppWeb.GraphQL.NoteQuery

  test "mutation: delete_note", %{conn: conn} do
    1..3
    |> Enum.each(fn index ->
      Redix.command(["SET", "title_#{index}", "body of note #{index}"])
    end)

    {:ok, notes} = Redix.command(["KEYS", "*"])
    assert length(notes) == 3

    conn =
      post(conn, "/api", %{
        "query" => NoteQuery.delete_note_query(),
        "variables" => %{
          title: "title_1"
        }
      })

    %{
      "data" => %{
        "deleteNote" => result
      }
    } = json_response(conn, 200)

    assert result == "success"

    {:ok, notes} = Redix.command(["KEYS", "*"])
    assert length(notes) == 2

    Redix.command(["FLUSHDB"])
  end

  test "mutation: delete_note not_found", %{conn: conn} do
    conn =
      post(conn, "/api", %{
        "query" => NoteQuery.delete_note_query(),
        "variables" => %{
          title: "random title"
        }
      })

    %{
      "data" => %{
        "deleteNote" => result
      },
      "errors" => errors
    } = json_response(conn, 200)

    assert result == nil
    assert errors |> List.first() |> Map.get("message") == "No notes found"

    Redix.command(["FLUSHDB"])
  end
end
