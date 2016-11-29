require IEx
defmodule HelloWorld.CommentController do
  use HelloWorld.Web, :controller

  alias HelloWorld.Comment

  def index(conn, %{"task_id" => task}) do
    comments = Repo.all(Comment)
    render(conn, "index.html", task: task, comments: comments)
  end

  def new(conn, %{"task_id" => task}) do
    #IEx.pry
    changeset = Comment.changeset(%Comment{})
    render(conn, "new.html", task: task, changeset: changeset)
  end

  def create(conn, %{"task_id" => task, "comment" => comment_params}) do
    changeset = Comment.changeset(%Comment{}, comment_params)

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: task_comment_path(conn, :index, task))
      {:error, changeset} ->
        render(conn, "new.html", task: task, changeset: changeset)
    end
  end

  def show(conn, %{"task_id" => task, "id" => id}) do
    comment = Repo.get!(Comment, id)
    render(conn, "show.html", task: task, comment: comment)
  end

  def edit(conn, %{"task_id" => task, "id" => id}) do
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Repo.get!(Comment, id)
    task = comment.task_id
    changeset = Comment.changeset(comment, comment_params)

    case Repo.update(changeset) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: task_comment_path(conn, :show, task))
      {:error, changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)
    task = comment.task_id
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: task_comment_path(conn, :index, task))
  end
end
