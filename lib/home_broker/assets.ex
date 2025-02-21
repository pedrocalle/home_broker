defmodule HomeBroker.Assets do
  alias HomeBroker.Assets.GetAll
  alias HomeBroker.Assets.Get
  alias HomeBroker.Assets.Create

  defdelegate create(params), to: Create, as: :call
  defdelegate get(symbol), to: Get, as: :call
  defdelegate get_all(), to: GetAll, as: :call
end
