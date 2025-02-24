defmodule HomeBroker.Assets.Create do
  alias Ecto.Changeset
  alias HomeBroker.MongoConnection
  alias HomeBroker.Assets.Asset

  def call(params) do
    case Asset.changeset(params) do
      %Changeset{valid?: false} = changeset -> {:error, changeset}
      changeset -> MongoConnection.get_conn() |> Mongo.insert_one("assets", changeset.changes)
    end
  end
end
