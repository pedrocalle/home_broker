defmodule HomeBroker.Assets.Create do
  alias HomeBroker.MongoConnection
  alias HomeBroker.Assets.Asset
  def call(params) do
    changeset = Asset.changeset(params)

    MongoConnection.get_conn()
    |> Mongo.insert_one("assets", changeset.changes)
  end
end
