defmodule VideoCallProject.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :isOnline, :boolean, default: false
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
    # |> validate_length(:password, min: 6, max: 100)
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6, max: 100)
    |> encrypt_and_put_passwrd()
  end

  def encrypt_and_put_passwrd(user) do
    with password <- fetch_field!(user, :password) do
      # IO.inspect(password)
      # encrypted_password = Bcrypt.Base.hash_password(password, Bcrypt.Base.gen_salt(12, true))
      encrypted_password = Bcrypt.hash_pwd_salt(password)
      IO.inspect(encrypted_password)
      # encrypted_password = Bcrypt.hash_pwd_salt(password)
      put_change(user, :password, encrypted_password)
    end
  end
end
