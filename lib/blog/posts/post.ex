defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Posts.Post

  @required_fields [:title, :content] 
  @optional_fields [:slug, :comment_enabled, :comment_count, :image, :featured, :tags, :status,
      :login_required, :start_publication, :end_publication, :publication_date, :image_caption
    ]
  @all_fields @required_fields ++ @optional_fields

  @status %{
    draft: 0,
    publish: 1,
    delete: 2
  }  

  schema "blog_posts" do
    field :title, :string 
    field :slug, :string
    field :content, :string
    field :comment_enabled, :boolean, default: true
    field :comment_count, :integer, default: 0
    field :image, :string
    field :featured, :boolean, default: false
    field :tags, :string
    field :login_required, :boolean, default: false 
    field :start_publication, :utc_datetime 
    field :end_publication, :utc_datetime
    field :publication_date, :utc_datetime
    field :image_caption, :string
    field :status, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
    |> update_change(:slug, &make_slug/1)
    |> unique_constraint(:slug)
  end

  def make_slug(slug) do
    slug 
    |> String.downcase
    |> String.trim
    |> String.replace(" ", "-") 
  end
end
