defmodule HomeBroker.Assets.GetAll do
  alias HomeBroker.MongoConnection
  def call() do
    conn = MongoConnection.get_conn()
    assets = Mongo.find(conn, "assets", %{})

    {:ok, assets.docs}
  end
end
