defmodule KrelloBackend.Router do
  use KrelloBackend.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Corsica, origins: "http://localhost:4200"
  end

  scope "/", KrelloBackend do
    pipe_through :api # Use the default browser stack

    resources "/boards", BoardController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", KrelloBackend do
    # pipe_through :api
  # end
end
