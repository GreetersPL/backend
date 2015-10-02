defmodule GreetersBackend.Walk do
  use GreetersBackend.Web, :model
  before_insert :add_flow__create_record
  after_insert :inform_on_channel__create_record
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "walks" do
    field :name, :string
    field :email, :string
    field :additional, :string
    embeds_many :flow, GreetersBackend.Flow
    embeds_many :languages, GreetersBackend.Language
    embeds_many :dates, GreetersBackend.Date

    timestamps
  end

  @required_fields ~w(name email)
  @optional_fields ~w(additional languages dates)

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

  def inform_on_channel__create_record(changeset) do
    changeset = %{changeset| action: :update, changes: %{}}
    GenServer.cast(:informer_server, {:walk, changeset})
    changeset
  end

end
