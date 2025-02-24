defmodule HomeBroker.WalletAssets.Create do
  alias HomeBroker.MongoConnection
  alias Ecto.Changeset
  alias HomeBroker.WalletAssets.WalletAsset

  def call(params) do
    conn = MongoConnection.get_conn()

    case WalletAsset.changeset(params) do
      %Changeset{valid?: true} = changeset ->
        Mongo.insert_one(conn, "wallet_assets", changeset.changes)
      changeset ->
        {:error, changeset}
    end
  end
end
