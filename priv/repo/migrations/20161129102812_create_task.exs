defmodule HelloWorld.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :body, :text

      timestamps()
    end

  end
end
