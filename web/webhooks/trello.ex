defmodule GreetersBackend.Webhooks.Trello do
  use HTTPoison.Base
  @trello_api_url  "https://api.trello.com/1/"
  @token Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:trello_api_token]
  @key Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:trello_api_key]

  def process_url(url) do
    @trello_api_url <> url <> "?key=#{@key}&token=#{@token}"
  end

  def create_new_card(changeset) do
    payload = _create_walk_payload(changeset)
    post("cards", payload)
  end

  def process_request_headers(headers) do
    Dict.put headers, :"Content-Type", "application/json"
  end

  defp process_request_body(body) do
    Poison.encode!(body)
  end

  defp process_response_body(body) do
    Poison.decode!(body)
  end

  defp _create_walk_payload(changeset) do
    description = "* Imię: #{Ecto.Changeset.get_field(changeset, :name)} \n"
      <> "* Email: #{Ecto.Changeset.get_field(changeset, :email)} \n"
      <> "* Języki: \n"
      <> "#{Ecto.Changeset.get_field(changeset, :languages) |> Enum.map_join("\n", &("  1. **#{&1.language}** - #{GreetersBackend.I18n.t!("pl","lang_level.#{&1.level}")}"))}\n"
      <> "* Daty: \n"
      <> "#{Ecto.Changeset.get_field(changeset, :dates) |> Enum.map_join("\n",  &("  1. **#{&1.date}**: *#{&1.from}* - *#{&1.to}*"))}\n"
      <> "* Dodatkowe informacje: \n > #{Ecto.Changeset.get_field(changeset, :additional)}"
    %{
      idList: Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:trello_list_id],
      name: Ecto.Changeset.get_field(changeset, :name),
      desc: description
    }
  end
end
