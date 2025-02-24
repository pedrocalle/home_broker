defmodule HomeBrokerWeb.AssetController do
  alias HomeBrokerWeb.FallbackController
  alias HomeBroker.Assets
  use HomeBrokerWeb, :controller

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, _asset} <- Assets.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, %{})
    end
  end

  def show(conn, %{"symbol" => symbol}) do
    with {:ok, asset} <- Assets.get(symbol) do
      conn
      |> put_status(:ok)
      |> render(:show, %{asset: asset})
    end
  end

  def index(conn, _params) do
    with {:ok, assets} <- Assets.get_all() do
      conn
      |> put_status(:ok)
      |> render(:index, %{assets: assets})
    end
  end
end
