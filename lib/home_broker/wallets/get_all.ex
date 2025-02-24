defmodule HomeBroker.Wallets.GetAll do
  alias HomeBroker.MongoConnection

  def call() do
    conn = MongoConnection.get_conn()
    assets = Mongo.find(conn, "wallets", %{})

    {:ok, assets.docs}
  end
end
