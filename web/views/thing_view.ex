defmodule ThingServer.ThingView do
  use ThingServer.Web, :view

  def render("index.json", %{things: things}) do
    %{data: render_many(things, ThingServer.ThingView, "thing.json")}
  end

  def render("show.json", %{thing: thing}) do
    %{data: render_one(thing, ThingServer.ThingView, "thing.json")}
  end

  def render("thing.json", %{thing: thing}) do
    %{id: thing.id,
      name: thing.name}
  end
end
