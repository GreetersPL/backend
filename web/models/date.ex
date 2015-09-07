defmodule GreetersBackend.Date do
  use GreetersBackend.Web, :model

  embedded_schema do
    field :date, :string
    field :from, :string
    field :to, :string
  end

  @required_fields ~w(date from to)
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
end
