defmodule GreetersBackend.Repo.Migrations.AddLangAndDatesTo_Walk do
  use Ecto.Migration

  def change do
    alter table(:walks) do
      add :dates, :jsonb
      add :languages, :jsonb
    end
  end
end
