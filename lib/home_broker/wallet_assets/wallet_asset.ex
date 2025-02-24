defmodule HomeBroker.WalletAssets.WalletAsset do
  alias Ecto.Changeset
  alias HomeBroker.MongoConnection

  use Ecto.Schema
  import Ecto.Changeset

  @fields [:shares, :wallet, :asset]

  embedded_schema do
    field :shares, :integer
    field :wallet, :string
    field :asset, :string
  end

  def changeset(asset \\ %__MODULE__{}, params) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    asset
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> put_change(:inserted_at, now)
    |> put_change(:updated_at, now)
    |> validate_reference()
  end

  defp validate_reference(%Changeset{valid?: true, changes: %{wallet: wallet, asset: asset}} = changeset) do
    conn = MongoConnection.get_conn()

    wallet_exists = Mongo.find_one(conn, "wallets", %{_id: BSON.ObjectId.decode!(wallet)})
    asset_exists = Mongo.find_one(conn, "assets", %{_id: BSON.ObjectId.decode!(asset)})

    cond do
      wallet_exists == nil -> add_error(changeset, :message, "Carteira não encontrada")
      asset_exists == nil -> add_error(changeset, :message, "Ativo não encontrado")
      true -> changeset
    end
  end

  defp validate_reference(changeset), do: changeset
end
