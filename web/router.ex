defmodule GreetersBackend.Router do
  use GreetersBackend.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug GreetersBackend.Plugs.Locale, GreetersBackend.I18n.default_lang
  end

  for locale <- GreetersBackend.I18n.other_langs do
    pipeline String.to_atom "locale_#{locale}" do
      plug GreetersBackend.Plugs.Locale, locale
    end
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
      scope "/#{locale}", as: locale do
        pipe_through [String.to_atom("locale_#{locale}")]
        get "/", PageController, :index
        get "/#{GreetersBackend.I18n.t!(locale, "routes.faq")}", PageController, :faq
        get "/#{GreetersBackend.I18n.t!(locale, "routes.about")}", PageController, :about
        get "/#{GreetersBackend.I18n.t!(locale, "routes.contact")}", PageController, :contact

        get "/#{GreetersBackend.I18n.t!(locale, "routes.search")}" , WalkController, :new
        post "/#{GreetersBackend.I18n.t!(locale, "routes.search")}" , WalkController, :create
      end

    end

  end




  # Other scopes may use custom stacks.
  # scope "/api", GreetersBackend do
  #   pipe_through :api
  # end
end
