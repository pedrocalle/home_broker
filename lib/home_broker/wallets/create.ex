defmodule HomeBroker.Wallets.Create do
  alias HomeBroker.Wallets.Wallet
  alias Ecto.Changeset
  alias HomeBroker.MongoConnection

  def call(params) do
    case Wallet.changeset(params) do
      %Changeset{valid?: false} = changeset -> {:error, changeset}
      changeset -> MongoConnection.get_conn() |> Mongo.insert_one("wallets", changeset.changes)
    end
  end
end
