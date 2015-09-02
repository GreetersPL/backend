defmodule GreetersBackend.Repo.Migrations.CreateWalk do
  use Ecto.Migration

  def change do
    create table(:walks, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :email, :string
      add :additional, :string
      add :flow, :jsonb

      timestamps
    end

  end
end
