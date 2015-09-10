defmodule GreetersBackend.WalkController do
  use GreetersBackend.Web, :controller

  alias GreetersBackend.Walk

  plug :scrub_params, "walk" when action in [:create]
  plug :accepts, ~w(html) when not action in [:create]

  def new(conn, _params) do
    changeset = Walk.changeset(%Walk{})
    assign(conn, :page_title, 'search')
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"walk" => walk_params}) do
    changeset = Walk.changeset(%Walk{}, walk_params)
    case Repo.insert(changeset) do
      {:ok, _walk} ->
        json conn, %{info: "Walk created successfully."}
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(changeset)
    end
  end

end
