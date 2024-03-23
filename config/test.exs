import Config

config :my_app, MyApp.Redix,
  host: System.get_env("REDIS_HOST_TEST"),
  port: System.get_env("REDIS_PORT_TEST"),
  db: System.get_env("REDIS_DB_TEST")

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :my_app, MyAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "W/B3sk2XTkiEr5nk+HMni2dYXM85NZmgH0IJAogghMEFFuav/aI37pQgr0fS99Yv",
  server: false

# In test we don't send emails.
config :my_app, MyApp.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
