require IEx
defmodule HelloWorld.CommentTest do
  use HelloWorld.ModelCase

  alias HelloWorld.Comment

  @valid_attrs %{body: "some content", task_id: 42}
  @invalid_attrs %{}
  @task_attrs %{body: "This is body of my task", name: "My first task"}

  test "changeset with valid attributes" do
    changeset = Comment.changeset(%Comment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Comment.changeset(%Comment{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "comment should belongs to task" do
    task_changeset = HelloWorld.Task.changeset(%HelloWorld.Task{}, @task_attrs)
    {:ok, task} = Repo.insert(task_changeset)

    valid_attr = %{body: "some content", task_id: task.id}
    comment_changeset = Comment.changeset(%Comment{}, valid_attr)

    {:ok, comment} = Repo.insert(comment_changeset)
    comment_task = Repo.preload(comment, :task)
    assert comment_task.task == task
  end
end
