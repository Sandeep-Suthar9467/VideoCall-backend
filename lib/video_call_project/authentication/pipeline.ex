defmodule VideoCallProject.Guardian.AuthPipelne do
    @claims %{typ: "access"}
    
    use Guardian.Plug.Pipeline,
    otp_app: :video_call_project,
    module: VideoCallProject.Guardian,
    error_handler: VideoCallProject.Guadian.AuthErrorHandler

    plug(Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer")
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(Guardian.Plug.LoadResource, ensure: true)
end