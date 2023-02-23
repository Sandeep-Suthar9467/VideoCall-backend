defmodule VideoCallProject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      VideoCallProject.Repo,
      # Start the Telemetry supervisor
      VideoCallProjectWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: VideoCallProject.PubSub},
      # Start the Endpoint (http/https)
      VideoCallProjectWeb.Endpoint
      # Start a worker by calling: VideoCallProject.Worker.start_link(arg)
      # {VideoCallProject.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VideoCallProject.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VideoCallProjectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
