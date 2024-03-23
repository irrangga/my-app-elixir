defmodule MyAppWeb.Note.Queries.ListNotesTest do
  use MyAppWeb.ConnCase

  alias MyApp.Redix
  alias MyAppWeb.GraphQL.NoteQuery

  test "query: list_notes", %{conn: conn} do
    1..3
    |> Enum.each(fn index ->
      Redix.command(["SET", "title_#{index}", "body of note #{index}"])
    end)

    conn =
      post(conn, "/api", %{
        "query" => NoteQuery.list_notes_query()
      })

    %{
      "data" => %{
        "listNotes" => result
      }
    } = json_response(conn, 200)

    assert length(result) == 3

    note_1 = Enum.find(result, fn note -> note["title"] == "title_1" end)
    assert note_1["title"] == "title_1"
    assert note_1["body"] == "body of note 1"

    note_2 = Enum.find(result, fn note -> note["title"] == "title_2" end)
    assert note_2["title"] == "title_2"
    assert note_2["body"] == "body of note 2"

    note_3 = Enum.find(result, fn note -> note["title"] == "title_3" end)
    assert note_3["title"] == "title_3"
    assert note_3["body"] == "body of note 3"

    Redix.command(["FLUSHDB"])
  end
end
