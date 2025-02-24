defmodule HomeBrokerWeb.AssetJSON do

  def show(%{asset: asset}), do: data(asset)

  def index(%{assets: assets}), do: Enum.map(assets, &data/1)

  def create(%{}), do: %{status: "created"}

  defp data(asset) do
    %{
      id: BSON.ObjectId.encode!(asset["_id"]),
      image: asset["image"],
      symbol: asset["symbol"],
      name: asset["name"],
      price: asset["price"],
      created_at: asset["created_at"],
      updated_at: asset["updated_at"]
    }
  end
end
