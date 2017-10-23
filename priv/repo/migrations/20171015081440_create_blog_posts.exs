defmodule Blog.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string 
      add :slug, :string
      add :content, :text
      add :comment_enabled, :boolean
      add :comment_count, :integer
      add :image, :string
      add :featured, :boolean
      add :tags, :text
      add :login_required, :boolean 
      add :start_publication, :utc_datetime 
      add :end_publication, :utc_datetime
      add :publication_date, :utc_datetime
      add :image_caption, :string
      add :status, :integer

      timestamps()
    end

  end
end
