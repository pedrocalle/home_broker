defmodule HomeBroker.MongoConnection do
  use GenServer

  @mongo_url "mongodb://root:root@localhost:27017/homebroker?authSource=admin&directConnection=true"

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get_conn do
    GenServer.call(__MODULE__, :get_conn)
  end

  @impl true
  def init(_) do
    {:ok, conn} = Mongo.start_link(url: @mongo_url)

    create_indexes(conn)

    {:ok, conn}
  end

  @impl true
  def handle_call(:get_conn, _from, conn) do
    {:reply, conn, conn}
  end

  defp create_indexes(conn) do
    Mongo.create_indexes(conn, "assets", [
      [key: %{symbol: 1}, name: "unique_symbol", unique: true]
    ])

    Mongo.create_indexes(conn, "wallet_assets", [
      [key: %{wallet_id: 1, asset_id: 1}, name: "wallet_asset_unique", unique: true]
    ])
  end
end
