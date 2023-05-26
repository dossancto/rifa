defmodule Rifa.Repo do
  use Ecto.Repo,
    otp_app: :rifa,
    adapter: Ecto.Adapters.Postgres
end
