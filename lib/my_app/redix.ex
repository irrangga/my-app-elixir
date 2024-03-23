defmodule MyApp.Redix do
  def redis_config do
    Application.get_env(:my_app, MyApp.Redix)
  end

  def redis_conn() do
    {:ok, conn} =
      Redix.start_link(
        "redis://#{redis_config()[:host]}:#{redis_config()[:port]}/#{redis_config()[:db]}"
      )

    conn
  end

  def command(command) do
    Redix.command(redis_conn(), command)
  end
end
