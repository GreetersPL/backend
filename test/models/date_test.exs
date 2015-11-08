defmodule GreetersBackend.DateTest do
  use GreetersBackend.ModelCase

  alias GreetersBackend.Date

  @valid_attrs %{}
  @invalid_attrs %{}

  @tag :skip
  test "changeset with valid attributes" do
    changeset = Date.changeset(%Date{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Date.changeset(%Date{}, @invalid_attrs)
    refute changeset.valid?
  end
end
