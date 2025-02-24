defmodule HomeBrokerWeb.WalletController do
  alias HomeBroker.Wallets
  alias HomeBrokerWeb.FallbackController
  use HomeBrokerWeb, :controller

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, _wallet} <- Wallets.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, %{})
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, wallet} <- Wallets.get(id) do
      conn
      |> put_status(:ok)
      |> render(:show, %{wallet: wallet})
    end
  end

  def index(conn, _params) do
    with {:ok, wallets} <- Wallets.get_all() do
      conn
      |> put_status(:ok)
      |> render(:index, %{wallets: wallets})
    end
  end

  def create_wallet_asset(conn, %{"wallet" => wallet_id} = params) do
    params = Map.put(params, "wallet", wallet_id)

    with {:ok, _wallet_asset} <- Wallets.create_wallet_asset(params) do
      conn
      |> put_status(:created)
      |> render(:create, %{})
    end
  end
end
