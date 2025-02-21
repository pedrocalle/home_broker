defmodule HomeBrokerWeb.AssetController do
  alias HomeBroker.Assets
  use HomeBrokerWeb, :controller

  def create(conn, params) do
    with {:ok, asset} <- Assets.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, %{asset: asset})
    end
  end

  def get(conn, %{"symbol" => symbol}) do
    with {:ok, asset} <- Assets.get(symbol) do
      conn
      |> put_status(:ok)
      |> render(:get, %{asset: asset})
    end
  end

  def get(conn, _params) do
    with {:ok, asset} <- Assets.get_all() do
      conn
      |> put_status(:ok)
      |> render(:get_all, %{asset: asset})
    end
  end
end
