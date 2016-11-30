defmodule HelloWorld.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      # add :task_id, :integer
      add :task_id, references(:tasks)  
      timestamps()
    end

  end
end
