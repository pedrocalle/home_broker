defmodule HomeBroker.Assets.Asset do
  alias Ecto.Changeset
  alias HomeBroker.MongoConnection

  use Ecto.Schema
  import Ecto.Changeset

  @fields [:name, :symbol, :image, :price]

  embedded_schema do
    field :name, :string
    field :symbol, :string
    field :image, :string
    field :price, :float

    timestamps()
  end

  def changeset(asset \\ %__MODULE__{}, params) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    asset
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_unique()
    |> put_change(:inserted_at, now)
    |> put_change(:updated_at, now)
  end

  defp validate_unique(%Changeset{valid?: true, changes: %{symbol: symbol}} = changeset) do
    conn = MongoConnection.get_conn()
    case Mongo.find_one(conn, "assets", %{symbol: symbol}) do
      nil -> changeset
      _asset -> add_error(changeset, :message, "Ativo já existente")
    end
  end

  defp validate_unique(changeset), do: changeset
end
