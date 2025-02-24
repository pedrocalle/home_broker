defmodule HomeBroker.Wallets.Get do
  alias HomeBroker.MongoConnection

  def call(id) do
    conn = MongoConnection.get_conn()

    case Mongo.find_one(conn, "wallets", %{"_id" => BSON.ObjectId.decode!(id)}) do
      nil -> {:error, :not_found}
      asset -> {:ok, asset}
    end
  end
end
