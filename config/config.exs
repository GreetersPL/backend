# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :greeters_backend, GreetersBackend.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "nUrWAD8cWVgVvOJPfY1JjXVyngnSKl8CXsl3G9SjvhM390Ytf2dgETBkEsimf3rk",
  render_errors: [default_format: "html"],
  pubsub: [name: GreetersBackend.PubSub,
           adapter: Phoenix.PubSub.PG2],
  walk_hook: "Hook from slack"         

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
