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
    
    for locale <- GreetersBackend.I18n.other_langs do
      get "/#{locale}", PageController, :index
      get "/#{locale}/#{GreetersBackend.I18n.t!(locale, "routes.faq")}", PageController, :faq
      get "/#{locale}/#{GreetersBackend.I18n.t!(locale, "routes.about")}", PageController, :about
      get "/#{locale}/#{GreetersBackend.I18n.t!(locale, "routes.contact")}", PageController, :contact

      get "/#{locale}/#{GreetersBackend.I18n.t!(locale, "routes.search")}" , WalkController, :new
      post "/#{locale}/#{GreetersBackend.I18n.t!(locale, "routes.search")}" , WalkController, :create


    end

  end




  # Other scopes may use custom stacks.
  # scope "/api", GreetersBackend do
  #   pipe_through :api
  # end
end
