defmodule KrelloBackend.BoardView do
  use KrelloBackend.Web, :view

  def render("index.json", %{boards: boards}) do
    %{board: render_many(boards, KrelloBackend.BoardView, "board.json")}
  end

  def render("show.json", %{board: board}) do
    %{board: render_one(board, KrelloBackend.BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    %{id: board.id,
      title: board.title,
      description: board.description}
  end
end
