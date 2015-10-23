defmodule GreetersBackend.WalkControllerTest do
  use GreetersBackend.ConnCase

  alias GreetersBackend.Walk
  @valid_attrs %{additional: "some content", email: "some content", id: "7488a646-e31f-11e4-aace-600308960662", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end


  test "renders form for new resources", %{conn: conn} do
    conn = get conn, walk_path(conn, :new)
    assert html_response(conn, 200) =~ "New walk"
  end

  test "creates resource", %{conn: conn} do
    conn = post conn, walk_path(conn, :create), walk: @valid_attrs
    assert json_response(conn, 200)
  end

  test "does not create resource and returns 422 status code", %{conn: conn} do
    conn = post conn, walk_path(conn, :create), walk: @invalid_attrs
    assert json_response(conn, 422)
  end

end
