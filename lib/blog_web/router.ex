defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {BlogWeb.LayoutView, "admin.html"}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlogWeb do
    pipe_through :browser # Use the default browser stack
    
    resources "/auth/users", UserController

    get "/", PageController, :index
    get "/login", AuthController, :login
    resources "/users", UserController
    post "/login", AuthController, :login
    get "/auth/users/:id/change_password", UserController, :change_password
    
  end

  scope "/dashboard", BlogWeb.Admin, as: :admin do
    pipe_through :admin # Use the default browser stack
    get "/", DashboardController, :index
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogWeb do
  #   pipe_through :api
  # end
end
