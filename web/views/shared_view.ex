defmodule GreetersBackend.SharedView do
  use GreetersBackend.Web, :view

  def navbar do
      [{"page", "index", "main_page"}, {"walk","new","search"}]
  end

  def get_page_url(lang, controller, function) do
    cond do
      lang == GreetersBackend.I18n.default_lang -> _get_page_url(controller, function)
      true -> _get_page_url(lang, controller, function)
    end
  end

  def actual_page_lang_path(lang, conn) do
    controller = conn
      |> Phoenix.Controller.controller_module
      |> Phoenix.Naming.resource_name("Controller")
    get_page_url(lang, controller, Phoenix.Controller.action_name(conn) )
  end

  def is_active_lang(conn, lang) do
    case(GreetersBackend.I18n.actual_lang(conn) == lang) do
      true -> "active"
      _ -> ""
    end
  end

  def is_actual_page(conn, controller, function) do
    actual_controller = conn
      |> Phoenix.Controller.controller_module
      |> Phoenix.Naming.resource_name("Controller")
    actual_function = conn
      |> Phoenix.Controller.action_name
      |> Atom.to_string
    case (actual_controller == controller && actual_function == function) do
      true -> "active"
      _ -> ""
    end
  end

  defp _get_page_url(controller, function) do
    {path, _} = Code.eval_string("GreetersBackend.Router.Helpers.#{controller}_path(GreetersBackend.Endpoint, :#{function})")
    path
  end

  defp _get_page_url(lang, controller, function) do
    {path, _} = Code.eval_string("GreetersBackend.Router.Helpers.#{lang}_#{controller}_path(GreetersBackend.Endpoint, :#{function})")
    path
  end

end
