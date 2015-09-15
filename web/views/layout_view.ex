defmodule GreetersBackend.LayoutView do
  use GreetersBackend.Web, :view


  def get_page_title(conn) do
    controller = conn
      |> Phoenix.Controller.controller_module
      |> Phoenix.Naming.resource_name("Controller")
    action = Phoenix.Controller.action_name(conn)
    case GreetersBackend.I18n.t(actual_lang(conn), "titles.#{controller}.#{action}") do
      {:error, _} -> GreetersBackend.I18n.t!(actual_lang(conn), "greeters_poland")
      {:ok, title} -> "#{title} | #{GreetersBackend.I18n.t!(actual_lang(conn), "greeters_poland")}"
    end
  end

end
