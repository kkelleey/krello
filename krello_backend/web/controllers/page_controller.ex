defmodule KrelloBackend.PageController do
  use KrelloBackend.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
