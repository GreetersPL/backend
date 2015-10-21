defmodule GreetersBackend.Webhooks.Slack do
  use HTTPoison.Base
  @webhook_url "https://hooks.slack.com/services/"
  @walk_hook Application.get_env(:greeters_backend, GreetersBackend.Endpoint)[:walk_hook]

  def process_url(url) do
    @webhook_url <> url
  end

  def send_webhook(changeset) do
    payload = _create_walk_payload(changeset)
    post(@walk_hook, payload)
  end

  defp process_request_body(body) do
    Poison.encode!(body)
  end

  defp _create_walk_payload(changeset) do
    languages = Ecto.Changeset.get_field(changeset, :languages)
                |> Enum.map_join("\n", &("*#{&1.language}* - #{GreetersBackend.I18n.t!("pl","lang_level.#{&1.level}")}"))
    dates = Ecto.Changeset.get_field(changeset, :dates)
            |> Enum.map_join("\n",  &("*#{&1.date}*: #{&1.from} - #{&1.to}"))
    %{
      username: "Zbyszek Greeter",
      attachments: [%{
        color: "good",
        fallback: "Nowe zapytanie o spacer",
        pretext: "Nowe zapytanie o spacer",
        mrkdwn_in: ["fields"],
        fields: [
          %{
            title: "Imię",
            value: Ecto.Changeset.get_field(changeset, :name),
            short: true
          }, %{
            title: "Email",
            value: Ecto.Changeset.get_field(changeset, :email),
            short: true
          }, %{
            title: "Języki",
            value: languages
            }, %{
              title: "Terminy",
              value: dates
              }, %{
                title: "Link do Treelo",
                value: Ecto.Changeset.get_field(changeset, :trello_uri)
              }
          ]
      }]
    }
  end

end
