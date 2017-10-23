defmodule Blog.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias Blog.Repo

  alias Blog.Users.User

  alias Blog.Utils.Helper


  @doc """
  Returns the list of auth_users.

  ## Examples

      iex> list_auth_users()
      [%User{}, ...]

  """
  def list_auth_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)


  def get_user_by(data) do 
    case Repo.get_by(User, data) do
      nil -> {:error, "No User Found"}
      user -> {:ok, user}    
    end
  end



  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
  
  def signup(attrs \\ %{}) do
    %User{}
    |> User.signup(attrs)
    |> Repo.insert()
  end

  def authenticate(user, username, password) do
    valid_password? = Helper.generate_password_hash(password) == user.encrypted_password
    if valid_password?, do: true, else: false
  end
end
