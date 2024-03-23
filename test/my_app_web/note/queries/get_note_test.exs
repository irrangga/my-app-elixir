defmodule MyAppWeb.Note.Queries.GetNoteTest do
  use MyAppWeb.ConnCase

  alias MyApp.Redix
  alias MyAppWeb.GraphQL.NoteQuery

  test "query: get_note", %{conn: conn} do
    note = %{
      title: "Note Title",
      body: "body of note"
    }

    Redix.command(["SET", note[:title], note[:body]])

    conn =
      post(conn, "/api", %{
        "query" => NoteQuery.get_note_query(),
        "variables" => %{
          title: note[:title]
        }
      })

    %{
      "data" => %{
        "getNote" => result
      }
    } = json_response(conn, 200)

    assert result["title"] == note[:title]
    assert result["body"] == note[:body]

    Redix.command(["FLUSHDB"])
  end
end
