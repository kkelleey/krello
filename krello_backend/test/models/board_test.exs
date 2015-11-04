defmodule KrelloBackend.BoardTest do
  use KrelloBackend.ModelCase

  alias KrelloBackend.Board

  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Board.changeset(%Board{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Board.changeset(%Board{}, @invalid_attrs)
    refute changeset.valid?
  end
end
