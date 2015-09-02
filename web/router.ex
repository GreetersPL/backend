defmodule GreetersBackend.Router do
  use GreetersBackend.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end


  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", GreetersBackend do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/szukaj", WalkController, :new
    post "/szukaj", WalkController, :create

  end




  # Other scopes may use custom stacks.
  # scope "/api", GreetersBackend do
  #   pipe_through :api
  # end
end
