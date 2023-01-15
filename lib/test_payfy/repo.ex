defmodule TestPayfy.Repo do
  use Ecto.Repo,
    otp_app: :test_payfy,
    adapter: Ecto.Adapters.Postgres
end
