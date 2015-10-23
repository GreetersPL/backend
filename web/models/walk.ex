defmodule GreetersBackend.Walk do
  use GreetersBackend.Web, :model
  require Logger
  before_insert :add_flow__create_record
  after_insert :inform_on_channels__create_record
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "walks" do
    field :name, :string
    field :email, :string
    field :additional, :string
    field :trello_uri, :string
    field :send_to_slack, :boolean
    embeds_many :flow, GreetersBackend.Flow
    embeds_many :languages, GreetersBackend.Language
    embeds_many :dates, GreetersBackend.Date

    timestamps
  end

  @required_fields ~w(name email languages dates)
  @optional_fields ~w(additional)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def add_flow__create_record(changeset) do
    changeset
    |> GreetersBackend.Flow.add_to_flow("Record created")
  end

  def inform_on_channels__create_record(changeset) do
    case Mix.env do
      :test ->
        Logger.debug "Informing about new walk"
        changeset
      _ ->
        id = %{changeset| changes: %{}}
        |> Ecto.Changeset.get_field(:id)
        Task.Supervisor.start_child(Informer.Supervisor, GreetersBackend.Walk, :inform_on_channels, [id])
        changeset
    end

  end

  def inform_on_channels(id, retry \\ 0)

  def inform_on_channels(id, retry) when retry < 3 do
    case GreetersBackend.Repo.get(GreetersBackend.Walk, id) do
      nil ->
        Logger.error "Walk #{id} couldn't be fetched, retrying #{retry+1} time"
        inform_on_channels(id, retry+1)
      model ->
        new_changeset = model
        |> changeset(%{})
        |> send_to_trello
        |> send_to_slack
        case GreetersBackend.Repo.update(new_changeset) do
          {:ok, _model} -> Logger.debug "Walk #{id} updated after informing"
          {:error, changeset} -> Logger.error "Walk #{id} not updated because #{changeset.errors}"
        end
    end
  end

  def inform_on_channels(id, retry) when retry == 3 do
     Logger.error "Walk #{id} could't be fetched, retrying 3 times, no more retrying"
  end


  defp send_to_trello(changeset) do
    Logger.debug("Started request to Trello")
    case GreetersBackend.Webhooks.Trello.create_new_card(changeset) do
       {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            Logger.info("Walk #{Ecto.Changeset.get_field(changeset, :id)} send to Trello")
            GreetersBackend.Flow.add_to_flow(changeset, "Send to trello")
            |> Ecto.Changeset.put_change(:trello_uri, body["shortUrl"])
      {:ok, %HTTPoison.Response{body: body}} ->
            Logger.error "Error during sending to #{Ecto.Changeset.get_field(changeset, :id)} Trello, error: '#{body}'"
            GreetersBackend.Flow.add_to_flow(changeset, "Trello error: '#{body}'")
      {:error, reason} ->
            Logger.error reason
            GreetersBackend.Flow.add_to_flow(changeset, "Trello error: '#{reason}'")
    end
  end

  defp send_to_slack(changeset) do
    Logger.debug("Started request to Slack")
    case GreetersBackend.Webhooks.Slack.send_webhook(changeset) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
            Logger.info("Walk #{Ecto.Changeset.get_field(changeset, :id)} send to Slack")
            GreetersBackend.Flow.add_to_flow(changeset, "Send to slack")
            |> Ecto.Changeset.put_change(:send_to_slack, true)
      {:ok, response} ->
            Logger.error("Error during sending #{Ecto.Changeset.get_field(changeset, :id)} to Slack, status code: #{response.status_code}")
            GreetersBackend.Flow.add_to_flow(changeset, "Slack error: '#{response.status_code}'")
      {:error, reason} ->
            Logger.error reason
            GreetersBackend.Flow.add_to_flow(changeset, "Slack error: '#{reason}'")
    end
  end

end
