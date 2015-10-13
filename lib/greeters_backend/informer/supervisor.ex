defmodule GreetersBackend.Informer.Supervisor do
  require Logger
  use Supervisor

  def start_link do
    Logger.debug "Start supervisora #{__MODULE__}"
     Supervisor.start_link(__MODULE__, [[name: __MODULE__]])
  end

  def init(opts) do
    children = [
      worker(GreetersBackend.Slack, [], []),
      worker(GreetersBackend.Trello, [], [])
    ]
    supervise(children, [strategy: :one_for_all ])
  end


end
