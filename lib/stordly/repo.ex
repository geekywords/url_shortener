defmodule Stordly.Repo do
  use Ecto.Repo,
    otp_app: :stordly,
    adapter: Ecto.Adapters.Postgres
end
