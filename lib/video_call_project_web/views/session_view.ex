defmodule VideoCallProjectWeb.SessionView do
    use VideoCallProjectWeb, :view

    def render("token.json", %{access_token: access_token}) do
        %{access_token: access_token}
    end
    
end