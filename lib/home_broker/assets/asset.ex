defmodule HomeBroker.Assets.Asset do
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
    asset
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
