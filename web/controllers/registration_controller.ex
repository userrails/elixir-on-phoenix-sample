# web/controllers/registration_controller.ex
defmodule HelloWorld.RegistrationController do
  use HelloWorld.Web, :controller
  alias HelloWorld.User

    def new(conn, _params) do
        changeset = User.changeset(%User{})
        render conn, changeset: changeset
    end

    def create(conn, %{"user" => user_params}) do
	  changeset = User.changeset(%User{}, user_params)

	  case HelloWorld.Registration.create(changeset, HelloWorld.Repo) do
	    {:ok, changeset} ->
	      conn
	      # if you want to put current_user into session after user register do below line
	      |> put_session(:current_user, changeset.id)
	      |> put_flash(:info, "Your account was created")
	      |> redirect(to: "/")
	    {:error, changeset} ->
	      conn
	      |> put_flash(:info, "Unable to create account")
	      |> render("new.html", changeset: changeset)
	  end
	end
end
