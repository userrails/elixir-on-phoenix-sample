defmodule HelloWorld.Repo.Migrations.AddColumnActiveToPosts do
  use Ecto.Migration

  def change do
  	alter table(:posts) do
  		add :is_active, :boolean, default: true, null: false
  	end
  end
end
