defmodule HelloWorld.Task do
  use HelloWorld.Web, :model

  schema "tasks" do
    field :name, :string
    field :body, :string

    has_many :comments, HelloWorld.Comment, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :body])
    |> validate_required([:name, :body])
  end
end
