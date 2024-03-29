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

  test "mutation: insert_note already_exist", %{conn: conn} do
    note = %{
      title: "Note Title",
      body: "body of note"
    }

    Redix.command(["SET", note[:title], note[:body]])

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
      },
      "errors" => errors
    } = json_response(conn, 200)

    assert result == nil
    assert errors |> List.first() |> Map.get("message") == "Note already exist"

    Redix.command(["FLUSHDB"])
  end
end
