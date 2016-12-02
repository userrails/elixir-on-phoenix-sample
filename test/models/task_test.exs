require IEx
defmodule HelloWorld.TaskTest do
  use HelloWorld.ModelCase

  alias HelloWorld.Task

  @valid_attrs %{body: "This is body of my task", name: "My first task"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Task.changeset(%Task{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Task.changeset(%Task{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "Task should have many comments" do
    task_changeset = Task.changeset(%Task{}, @valid_attrs)
    {status, task} = Repo.insert(task_changeset)  
    
    comment_changeset1 = HelloWorld.Comment.changeset(%HelloWorld.Comment{body: "This is awesome task1!", task_id: task.id})
    {status, comment1} = Repo.insert(comment_changeset1)

    comment_changeset2 = HelloWorld.Comment.changeset(%HelloWorld.Comment{body: "This is awesome task2!", task_id: task.id})
    {status, comment2} = Repo.insert(comment_changeset2)

    task_comments = HelloWorld.Repo.get(HelloWorld.Task, task.id) |> HelloWorld.Repo.preload(:comments)
    assert task_comments.comments == [comment1, comment2]
  end

  test "it should delete all dependent comments when task is deleted" do
    task_changeset = Task.changeset(%Task{}, @valid_attrs)
    {status, task} = Repo.insert(task_changeset)

    comment_changeset1 = HelloWorld.Comment.changeset(%HelloWorld.Comment{body: "This is awesome task1!", task_id: task.id})
    {status, comment1} = Repo.insert(comment_changeset1)

    HelloWorld.Repo.delete(task)
    tsk = HelloWorld.Repo.get(HelloWorld.Task, task.id)
    cmt = HelloWorld.Repo.get(HelloWorld.Comment, comment1.id)

    assert tsk == nil
    assert cmt == nil
  end
end
