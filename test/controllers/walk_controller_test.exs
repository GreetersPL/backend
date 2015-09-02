defmodule GreetersBackend.WalkControllerTest do
  use GreetersBackend.ConnCase

  alias GreetersBackend.Walk
  @valid_attrs %{additional: "some content", email: "some content", id: "7488a646-e31f-11e4-aace-600308960662", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, walk_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing walks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, walk_path(conn, :new)
    assert html_response(conn, 200) =~ "New walk"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, walk_path(conn, :create), walk: @valid_attrs
    assert redirected_to(conn) == walk_path(conn, :index)
    assert Repo.get_by(Walk, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, walk_path(conn, :create), walk: @invalid_attrs
    assert html_response(conn, 200) =~ "New walk"
  end

  test "shows chosen resource", %{conn: conn} do
    walk = Repo.insert! %Walk{}
    conn = get conn, walk_path(conn, :show, walk)
    assert html_response(conn, 200) =~ "Show walk"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, walk_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    walk = Repo.insert! %Walk{}
    conn = get conn, walk_path(conn, :edit, walk)
    assert html_response(conn, 200) =~ "Edit walk"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    walk = Repo.insert! %Walk{}
    conn = put conn, walk_path(conn, :update, walk), walk: @valid_attrs
    assert redirected_to(conn) == walk_path(conn, :show, walk)
    assert Repo.get_by(Walk, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    walk = Repo.insert! %Walk{}
    conn = put conn, walk_path(conn, :update, walk), walk: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit walk"
  end

  test "deletes chosen resource", %{conn: conn} do
    walk = Repo.insert! %Walk{}
    conn = delete conn, walk_path(conn, :delete, walk)
    assert redirected_to(conn) == walk_path(conn, :index)
    refute Repo.get(Walk, walk.id)
  end
end
