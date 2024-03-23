defmodule MyAppWeb.Note.Queries.UpdateNoteTest do
  use MyAppWeb.ConnCase

  alias MyApp.Redix
  alias MyAppWeb.GraphQL.NoteQuery

  test "mutation: update_note", %{conn: conn} do
    note = %{
      title: "Note Title",
      body: "body of note"
    }

    Redix.command(["SET", note[:title], note[:body]])

    conn =
      post(conn, "/api", %{
        "query" => NoteQuery.update_note_query(),
        "variables" => %{
          title: note[:title],
          body: "this body is updated"
        }
      })

    %{
      "data" => %{
        "updateNote" => result
      }
    } = json_response(conn, 200)

    assert result == "success"

    {:ok, note_result} = Redix.command(["GET", note[:title]])
    assert note_result == "this body is updated"

    Redix.command(["FLUSHDB"])
  end

  test "mutation: update_note not_found", %{conn: conn} do
    conn =
      post(conn, "/api", %{
        "query" => NoteQuery.update_note_query(),
        "variables" => %{
          title: "random title",
          body: "random body"
        }
      })

    %{
      "data" => %{
        "updateNote" => result
      },
      "errors" => errors
    } = json_response(conn, 200)

    assert result == nil
    assert errors |> List.first() |> Map.get("message") == "No notes found"

    Redix.command(["FLUSHDB"])
  end
end
