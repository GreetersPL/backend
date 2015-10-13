defmodule GreetersBackend.Slack do
  require Logger
  use GenServer

  def new_walk_webhook(changeset) do
    GenServer.call(__MODULE__,{:walk, changeset})
  end


  def start_link do
     GenServer.start_link(__MODULE__, [], [name: __MODULE__])
   end

  def handle_call({:walk, changeset}, _from, state) do
    Logger.debug("Started request to Slack")
    case GreetersBackend.Slack.Webhook.send_webhook(:walk, changeset) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                        Logger.info("Walk #{Ecto.Changeset.get_field(changeset, :id)} send to Slack")
                        GreetersBackend.Flow.add_to_flow(changeset, "Send to slack") |> GreetersBackend.Repo.update
                        {:reply, :ok, []}
      {:ok, response} ->  Logger.error("Error during sending #{Ecto.Changeset.get_field(changeset, :id)} to Slack, status code: #{response.status_code}")
                          GreetersBackend.Flow.add_to_flow(changeset, "Error during send to slack, status_code: #{response.status_code}") |> GreetersBackend.Repo.update
                          {:reply, :error, []}
      {:error, reason} -> Logger.error reason
    end
  end

end
