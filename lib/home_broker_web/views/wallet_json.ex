defmodule HomeBrokerWeb.WalletJSON do
  def show(%{wallet: wallet}), do: data(wallet)

  def index(%{wallets: wallets}), do: Enum.map(wallets, &data/1)

  def create(%{}), do: %{status: "created"}

  defp data(wallet) do
    %{
      id: BSON.ObjectId.encode!(wallet["_id"]),
      created_at: wallet["created_at"],
      updated_at: wallet["updated_at"]
    }
  end
end
