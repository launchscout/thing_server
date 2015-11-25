defmodule ThingServer.ThingControllerTest do
  use ThingServer.ConnCase

  alias ThingServer.Thing
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, thing_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    thing = Repo.insert! %Thing{}
    conn = get conn, thing_path(conn, :show, thing)
    assert json_response(conn, 200)["data"] == %{"id" => thing.id,
      "name" => thing.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, thing_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, thing_path(conn, :create), thing: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Thing, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, thing_path(conn, :create), thing: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    thing = Repo.insert! %Thing{}
    conn = put conn, thing_path(conn, :update, thing), thing: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Thing, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    thing = Repo.insert! %Thing{}
    conn = put conn, thing_path(conn, :update, thing), thing: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    thing = Repo.insert! %Thing{}
    conn = delete conn, thing_path(conn, :delete, thing)
    assert response(conn, 204)
    refute Repo.get(Thing, thing.id)
  end
end
