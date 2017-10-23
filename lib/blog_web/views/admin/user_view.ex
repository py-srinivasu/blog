defmodule BlogWeb.Admin.UserView do
  use BlogWeb, :view

  def user_data() do
    IO.inspect "This is User Data"
    "Hello, This Is User Data"
  end

end
