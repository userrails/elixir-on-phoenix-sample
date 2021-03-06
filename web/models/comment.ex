defmodule HelloWorld.Comment do
  use HelloWorld.Web, :model

  schema "comments" do
    field :body, :string
    belongs_to :task, HelloWorld.Task
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :task_id])
    |> validate_required([:body, :task_id])
  end
end
