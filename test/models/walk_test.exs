defmodule GreetersBackend.WalkTest do
  use GreetersBackend.ModelCase

  alias GreetersBackend.Walk

  @valid_attrs %{additional: "some content", email: "some content", id: "7488a646-e31f-11e4-aace-600308960662", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Walk.changeset(%Walk{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Walk.changeset(%Walk{}, @invalid_attrs)
    refute changeset.valid?
  end
end
