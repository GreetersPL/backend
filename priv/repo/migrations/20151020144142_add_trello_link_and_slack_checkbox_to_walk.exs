defmodule GreetersBackend.Repo.Migrations.AddTrelloLinkAndSlackCheckboxToWalk do
  use Ecto.Migration

  def change do
    alter table(:walks) do
      add :trello_uri, :string
      add :send_to_slack, :boolean, default: false
    end
  end
end
