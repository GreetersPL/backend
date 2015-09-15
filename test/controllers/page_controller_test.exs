defmodule GreetersBackend.PageControllerTest do
  use GreetersBackend.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ GreetersBackend.I18n.t!(GreetersBackend.I18n.default_lang, "greeters_poland")
  end
end
