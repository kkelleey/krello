defmodule KrelloBackend.BoardControllerTest do
  use KrelloBackend.ConnCase

  alias KrelloBackend.Board
  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, board_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    board = Repo.insert! %Board{}
    conn = get conn, board_path(conn, :show, board)
    assert json_response(conn, 200)["data"] == %{"id" => board.id,
      "title" => board.title,
      "description" => board.description}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, board_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, board_path(conn, :create), board: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Board, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, board_path(conn, :create), board: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    board = Repo.insert! %Board{}
    conn = put conn, board_path(conn, :update, board), board: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Board, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    board = Repo.insert! %Board{}
    conn = put conn, board_path(conn, :update, board), board: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    board = Repo.insert! %Board{}
    conn = delete conn, board_path(conn, :delete, board)
    assert response(conn, 204)
    refute Repo.get(Board, board.id)
  end
end
