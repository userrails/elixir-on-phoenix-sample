# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HelloWorld.Repo.insert!(%HelloWorld.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


#post = %HelloWorld.Post{title: "title", body: "deadfda"}
#HelloWorld.Repo.insert(post)

for i <- 1..78300 do 
	post = %HelloWorld.Post{title: "titafsdfdsleasdfdfsfds#{i}#{i}", body: "this is realadfdfsdsfsdffdly a descriptaadfsdsfdasfdfion#{i}#{i}"}
    HelloWorld.Repo.insert(post)
end