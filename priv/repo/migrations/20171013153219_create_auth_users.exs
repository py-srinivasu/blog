defmodule Blog.Repo.Migrations.CreateAuthUsers do
  use Ecto.Migration

  def change do
    create table(:auth_users) do
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :mobile_number, :string
      add :is_staf, :boolean, default: false, null: false
      add :is_active, :boolean, default: false, null: false
      add :encrypted_password, :string
      add :date_joined, :utc_datetime
      add :last_logged_in, :utc_datetime

      timestamps()
    end
    
    create unique_index(:auth_users, [:email])

  end
end