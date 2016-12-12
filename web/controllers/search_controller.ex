require IEx
defmodule HelloWorld.SearchController do
	use HelloWorld.Web, :controller
    alias HelloWorld.Post

	def index(conn, _params) do
		 search_params = conn.params["search"]
		 column = search_params["column"]
		 keyword = search_params["keyword"]

		 cond do
		 	column == "id" -> query = from p in HelloWorld.Post, where: p.id == ^keyword, select: p
		 	column == "title" -> query = from p in HelloWorld.Post, where: p.title == ^keyword, select: p
		 	true -> query = from p in HelloWorld.Post, select: p
		 end
		
		posts = Repo.all(query)
		render(conn, "index.html", posts: posts)
	end
end
