defmodule GreetersBackend.Informer.GenServer do
  use GenServer

  def start_link do
     GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def inform_new_walk(changeset) do
    GenServer.cast(__MODULE__, {:walk, changeset})
  end

  def handle_cast({:walk, changeset}, state) do
    {:ok, sup} = GreetersBackend.Informer.Supervisor.start_link
    GreetersBackend.Trello.new_walk_webhook(changeset)
    GreetersBackend.Slack.new_walk_webhook(changeset)
    {:noreply, state}
  end
end
