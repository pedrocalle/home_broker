defmodule HomeBroker.Wallets.Wallet do

  use Ecto.Schema
  import Ecto.Changeset

  @fields []

  embedded_schema do

    timestamps()
  end

  def changeset(wallet \\ %__MODULE__{}, params) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    wallet
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> put_change(:inserted_at, now)
    |> put_change(:updated_at, now)
  end
end
