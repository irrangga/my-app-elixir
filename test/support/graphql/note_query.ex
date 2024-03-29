defmodule MyAppWeb.GraphQL.NoteQuery do
  def list_notes_query() do
    """
    query LIST_NOTES {
      listNotes {
        title
        body
      }
    }
    """
  end

  def get_note_query() do
    """
    query GET_NOTE(
      $title: String!
    ) {
      getNote(
        title: $title
      ) {
        title
        body
      }
    }
    """
  end

  def insert_note_query() do
    """
    mutation INSERT_NOTE(
      $title: String!
      $body: String!
    ) {
      insertNote(
        title: $title
        body: $body
      )
    }
    """
  end

  def update_note_query() do
    """
    mutation UPDATE_NOTE(
      $title: String!
      $body: String!
    ) {
      updateNote(
        title: $title
        body: $body
      )
    }
    """
  end

  def delete_note_query() do
    """
    mutation DELETE_NOTE(
      $title: String!
    ) {
      deleteNote(
        title: $title
      )
    }
    """
  end
end
