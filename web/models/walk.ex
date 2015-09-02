defmodule GreetersBackend.Walk do
  use GreetersBackend.Web, :model

  before_insert :add_flow__create_record
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "walks" do
    field :name, :string
    field :email, :string
    field :additional, :string
    embeds_many :flow, GreetersBackend.Flow

    timestamps
  end

  @required_fields ~w(name email additional)
  @optional_fields ~w()

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
    |> Ecto.Changeset.put_change(:flow, [%GreetersBackend.Flow{date: Ecto.DateTime.local(), operation: "Record created"}])
  end

end
