defmodule GreetersBackend.Informer do
  require Logger
  use GenServer

  def start_link(state, opts) do
     GenServer.start_link(__MODULE__, state, opts)
  end

  def init(state) do
    {:ok, slack_pid} = GreetersBackend.Slack.start_link([], [])
    {:ok, trello_pid} = GreetersBackend.Trello.start_link([], [])
    new_state = [slack_pid: slack_pid, trello_pid: trello_pid]
    {:ok, new_state}
  end

  def handle_cast({:walk, changeset}, state) do
    GenServer.call(state[:trello_pid],{:walk, changeset})
    GenServer.call(state[:slack_pid],{:walk, changeset})
    {:noreply, state}
  end

end
