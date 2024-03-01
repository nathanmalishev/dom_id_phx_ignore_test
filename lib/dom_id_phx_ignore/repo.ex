defmodule DomIdPhxIgnore.Repo do
  use Ecto.Repo,
    otp_app: :dom_id_phx_ignore,
    adapter: Ecto.Adapters.Postgres
end
