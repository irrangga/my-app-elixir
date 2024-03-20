defmodule MyApp.Accounts do
  alias MyApp.{Accounts, Repo}

  def find_user(id) do
    Repo.get(Accounts.User, id)
  end
end
