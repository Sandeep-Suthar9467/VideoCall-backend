defmodule VideoCallProject.Repo do
  use Ecto.Repo,
    otp_app: :video_call_project,
    adapter: Ecto.Adapters.Postgres
end
