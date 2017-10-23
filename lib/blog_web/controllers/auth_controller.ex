defmodule BlogWeb.AuthController do
  use BlogWeb, :controller

  alias Blog.Users
  alias Blog.Utils.Helper

  def login(conn, params) do
    case conn.method do
      "GET" ->
        render(conn, "login.html")
      "POST" ->
        email = params["login"]["email"]
        password = params["login"]["password"]
        with false <- Helper.is_empty(email),
             false <- Helper.is_empty(password),
             {:ok, user} <- Users.get_user_by(email: email),
             true <- Users.authenticate(user, email, password)
        do
          #create_session(user)
          conn 
            |> put_flash(:info, "Successfully Logged In!!")
            |> redirect(to: page_path(conn, :index))
        else  
          {:error, message} -> 
            conn 
            |> put_flash(:error, message)
            |> render("login.html")
          _ ->
            conn 
            |> put_flash(:error, "Invalid Credentials")
            |> render("login.html")    
        end        
    end
  end

  def signup(conn, %{"signup" => user_params}) do
    case Users.signup(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "signup.html", changeset: changeset)
    end  
  end
  
  def logout(conn, _params) do
    redirect(conn, to: page_path(conn, :index))
  end
end