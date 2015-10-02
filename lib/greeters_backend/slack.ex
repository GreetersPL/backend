defmodule GreetersBackend.Slack do
  require Logger
  use GenServer

  def start_link(state, opts) do
     GenServer.start_link(__MODULE__, state, opts)
   end

  def handle_call({:walk, changeset}, _from, state) do
    Logger.info("Started request")
    case GreetersBackend.Slack.Webhook.send_webhook(:walk, changeset) do
      {:ok, response} -> Logger.info("Walk #{Ecto.Changeset.get_field(changeset, :id)} send to Slack")
                         GreetersBackend.Flow.add_to_flow(changeset, "Send to slack") |> GreetersBackend.Repo.update
      {:error, reason} -> Logger.error reason
    end
    {:reply, :ok, []}
  end

end
