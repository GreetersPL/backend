defmodule GreetersBackend.I18n do
  use Linguist.Vocabulary

  locale "pl", Path.join([__DIR__, "../config/locales/pl.exs"])
  locale "en", Path.join([__DIR__, "../config/locales/en.exs"])

  def default_lang do
    Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:default_lang]
  end

  def other_langs do
    GreetersBackend.I18n.locales |> Enum.filter(fn(locale)-> locale !== default_lang  end)
  end

  def actual_lang(conn) do
    conn.assigns.locale
  end

  def enabled_langs do
    GreetersBackend.I18n.locales
  end
  
end
