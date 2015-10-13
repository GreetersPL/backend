defmodule GreetersBackend.Trello.Webhook do
  use HTTPoison.Base
  @trello_api_url  "https://api.trello.com/1/"
  @token Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:trello_api_token]
  @key Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:trello_api_key]

  def process_url(url) do
    @trello_api_url <> url <> "?key=#{@key}&token=#{@token}"
  end

  def create_new_card(changeset) do
    payload = _create_walk_payload(changeset)
    GreetersBackend.Trello.Webhook.post("cards", payload)
  end

  def process_request_headers(headers) do
    Dict.put headers, :"Content-Type", "application/json"
  end

  defp process_request_body(body) do
    Poison.encode!(body)
  end

  defp _create_walk_payload(changeset) do
    description = "* Imię: #{Ecto.Changeset.get_field(changeset, :name)} \n"
      <> "* Email: #{Ecto.Changeset.get_field(changeset, :email)} \n"
      <> "* Języki: \n"
      <> "** Język | Poziom \n ------- | --------- \n Raz | Dwa"
    %{
      idList: Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:trello_list_id],
      name: Ecto.Changeset.get_field(changeset, :name),
      desc: description
    }
  end
end
