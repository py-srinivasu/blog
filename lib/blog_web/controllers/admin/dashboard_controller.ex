defmodule BlogWeb.Admin.DashboardController do
  use BlogWeb, :controller
  
  def index(conn, _params) do
    conn = assign(conn, :title, "Dashboard")
    render(conn, "index.html")
  end
  
end