defmodule GreetersBackend.Trello do
  require Logger
  use GenServer

  def start_link(state, opts) do
     GenServer.start_link(__MODULE__, state, opts)
  end

  def handle_call({:walk, changeset}, _from, state) do
    Logger.info("Started request to Trello")
    case GreetersBackend.Trello.Webhook.create_new_card(changeset) do
      {:ok, response} -> IO.inspect response
                         Logger.info("Walk #{Ecto.Changeset.get_field(changeset, :id)} send to trello")
                         GreetersBackend.Flow.add_to_flow(changeset, "Send to trello") |> GreetersBackend.Repo.update
      {:error, reason} -> Logger.error reason
    end
    {:reply, :ok, []}
  end

end
