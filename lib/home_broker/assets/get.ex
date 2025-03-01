defmodule HomeBroker.Assets.Get do
  alias HomeBroker.MongoConnection
  def call(symbol) do
    conn = MongoConnection.get_conn()
    case Mongo.find_one(conn, "assets", %{"symbol" => symbol}) do
      nil -> {:error, :not_found}
      asset -> {:ok, asset}
    end
  end
end
