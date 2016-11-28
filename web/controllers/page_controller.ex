require IEx
defmodule HelloWorld.PageController do
  use HelloWorld.Web, :controller

  def index(conn, _params) do
        #IEx.pry
    render conn, "index.html"
  end
end
