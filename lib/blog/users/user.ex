defmodule Blog.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Users.User
  alias Blog.Utils.Helper

  @required_fields [:email, :first_name, :last_name, :mobile_number]
  @optional_fields [:password, :confirm_password, :encrypted_password, :is_staf, :is_active, :date_joined, :last_logged_in]
  @password_fields [:password, :confirm_password]
  @password_min_length 6

  schema "auth_users" do
    field :email, :string
    field :password, :string, virtual: true
    field :confirm_password, :string, virtual: true
    field :encrypted_password, :string
    field :first_name, :string
    field :is_active, :boolean, default: false
    field :is_staf, :boolean, default: false
    field :last_name, :string
    field :date_joined, :utc_datetime, default: Ecto.DateTime.utc(:usec)
    field :last_logged_in, :utc_datetime, default: Ecto.DateTime.utc(:usec)    
    field :mobile_number, :string

    timestamps()
  end
  

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
    |> validate_update_password()
  end

  @doc false
  def signup(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_required(@password_fields)
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
    |> validate_length(:password, min: @password_min_length)
    |> validate_password()
    |> generate_encrypted_password()
  end
  
  defp validate_update_password(changeset) do
    password = get_change(changeset, :password)
    if password != nil and String.length(password) >= @password_min_length do
      validate_password(changeset)
    else
      changeset  
    end 
  end

  defp validate_password(changeset) do
    password = get_change(changeset, :password)
    conf_password = get_change(changeset, :confirm_password)
    if password == conf_password do
      changeset
    else
      add_error(changeset, :confirm_password, "Password and Confirm Password not match.")
    end
  end

  defp generate_encrypted_password(changeset) do
    password = get_change(changeset, :password)
    hash_password = if password, do: Helper.generate_password_hash(password), else: ""
    put_change(changeset, :encrypted_password, hash_password)
  end
  
end
