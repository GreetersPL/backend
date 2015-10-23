defmodule GreetersBackend.FlowTest do
  use GreetersBackend.ModelCase

  alias GreetersBackend.Flow

  @valid_attrs %{}
  @invalid_attrs %{}

  @tag :skip
  test "changeset with valid attributes" do
    changeset = Flow.changeset(%Flow{}, @valid_attrs)
    assert changeset.valid?
  end

  @tag :skip
  test "changeset with invalid attributes" do
    changeset = Flow.changeset(%Flow{}, @invalid_attrs)
    refute changeset.valid?
  end
end
