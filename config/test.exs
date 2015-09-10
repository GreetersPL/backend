use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :greeters_backend, GreetersBackend.Endpoint,
  http: [port: 4001],
  server: false,
  default_lang: "en"


# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :greeters_backend, GreetersBackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "greeters_backend_test",
  pool: Ecto.Adapters.SQL.Sandbox
