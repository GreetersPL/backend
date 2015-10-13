defmodule GreetersBackend.Trello do
  require Logger
  use GenServer

  def start_link do
     GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def new_walk_webhook(changeset) do
    GenServer.call(__MODULE__,{:walk, changeset})
  end

  def handle_call({:walk, changeset}, _from, state) do
    Logger.debug("Started request to Trello")
    case GreetersBackend.Trello.Webhook.create_new_card(changeset) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> Logger.info("Walk #{Ecto.Changeset.get_field(changeset, :id)} send to Trello")
                         GreetersBackend.Flow.add_to_flow(changeset, "Send to trello") |> GreetersBackend.Repo.update
      {:ok, %HTTPoison.Response{body: body}} ->Logger.error "Error during sending to Trello, error: '#{body}'"
          GreetersBackend.Flow.add_to_flow(changeset, "Error during sending to Trello, error: '#{body}'") |> GreetersBackend.Repo.update
      {:error, reason} -> Logger.error reason
    end
    {:reply, :ok, []}
  end

end
