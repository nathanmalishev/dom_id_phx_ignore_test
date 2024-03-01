defmodule DomIdPhxIgnore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DomIdPhxIgnoreWeb.Telemetry,
      DomIdPhxIgnore.Repo,
      {DNSCluster, query: Application.get_env(:dom_id_phx_ignore, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DomIdPhxIgnore.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DomIdPhxIgnore.Finch},
      # Start a worker by calling: DomIdPhxIgnore.Worker.start_link(arg)
      # {DomIdPhxIgnore.Worker, arg},
      # Start to serve requests, typically the last entry
      DomIdPhxIgnoreWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DomIdPhxIgnore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DomIdPhxIgnoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
