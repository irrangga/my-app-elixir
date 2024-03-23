defmodule MyAppWeb.Note.Queries.InsertNoteTest do
  use MyAppWeb.ConnCase

  alias MyApp.Redix
  alias MyAppWeb.GraphQL.NoteQuery

  test "mutation: insert_note", %{conn: conn} do
    note = %{
      title: "Note Title",
      body: "body of note"
    }

    conn =
      post(conn, "/api", %{
        "query" => NoteQuery.insert_note_query(),
        "variables" => %{
          title: note[:title],
          body: note[:body]
        }
      })

    %{
      "data" => %{
        "insertNote" => result
      }
    } = json_response(conn, 200)

    assert result == "success"

    {:ok, note_result} = Redix.command(["GET", note[:title]])
    assert note_result == note[:body]

    Redix.command(["FLUSHDB"])
  end
end
