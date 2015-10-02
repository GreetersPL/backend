defmodule GreetersBackend.Trello.Webhook do
  use HTTPoison.Base
  @trello_api_url  "https://api.trello.com/1/"

  def process_url(url) do
    @trello_api_url <> url <> "?key=#{Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:trello_api_key]}"
  end

  def create_new_card(changeset) do
    payload = _create_walk_payload(changeset)
    GreetersBackend.Trello.Webhook.post("cards", payload)
  end

  defp process_request_body(body) do
    Poison.encode!(body)
  end

  defp _create_walk_payload(changeset) do
    %{
      name: "test",
      idList: Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:trello_list_id]
    }
  end
end
