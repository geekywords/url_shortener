import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :stordly, Stordly.Repo,
  username: "postgres",
  password: "postgress",
  hostname: "localhost",
  port: 5433,
  database: "stordly_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stordly, StordlyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "GKAOOCoR6h+iaWiyTQLnMjMy/x3MHueg4krK0ATlnpVdrpHp3mcTH+nSHJ2Pm5nt",
  server: true

# In test we don't send emails.
config :stordly, Stordly.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :stordly, :sandbox, Ecto.Adapters.SQL.Sandbox
config :wallaby, screenshot_on_failure: true
config :wallaby, otp_app: :stordly
