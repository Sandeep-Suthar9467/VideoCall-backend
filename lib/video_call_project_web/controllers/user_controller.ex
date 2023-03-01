defmodule VideoCallProjectWeb.UserController do
  use VideoCallProjectWeb, :controller

  alias VideoCallProject.Accounts
  alias VideoCallProject.Accounts.User

  action_fallback VideoCallProjectWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end


  def register(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
    {:ok, %User{} = user} ->
     body = Jason.encode!(%{success: "User created succesfully"})
      conn
      |> put_status(:created)
      |> send_resp(200, body)
      # |> put_resp_header("location", Routes.user_path(conn, :show, user))
      # |> render("show.json", user: user)

      {:error, _} ->
          body = Jason.encode!(%{error: "user already exists",status: 400})
          conn
            |> send_resp(400, body)



    end

  end



  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
