defmodule HelloWorld.Router do
  use HelloWorld.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWorld do
    pipe_through :browser # Use the default browser stack

    # get "/", PageController, :index
    get "/", DashboardController, :index 
    # additional resources we will use here
    resources "/posts", PostController
    resources "/dashboards", DashboardController, only: [:index]
    resources "/tasks", TaskController do
      resources "/comments", CommentController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWorld do
  #   pipe_through :api
  # end
end
