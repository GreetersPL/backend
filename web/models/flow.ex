defmodule GreetersBackend.Flow do
  use GreetersBackend.Web, :model

  embedded_schema do
    field :date, Ecto.DateTime
    field :operation, :string
  end

  @required_fields ~w(date, operation)
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

  def add_to_flow(changeset ,message) do
    Ecto.Changeset.get_field(changeset, :flow)
    |> _add_to_flow(changeset, message)
  end

  defp _add_to_flow(flow, changeset, message) when is_list(flow) do
    Ecto.Changeset.put_change(changeset, :flow, flow++[%GreetersBackend.Flow{date: Ecto.DateTime.local(), operation: message }])
  end

end
