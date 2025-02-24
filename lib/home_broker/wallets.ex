defmodule HomeBroker.Wallets do
  alias HomeBroker.WalletAssets
  alias HomeBroker.Wallets.Get
  alias HomeBroker.Wallets.GetAll
  alias HomeBroker.Wallets.Create

  defdelegate create(params), to: Create, as: :call
  defdelegate get_all(), to: GetAll, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate create_wallet_asset(params), to: WalletAssets.Create, as: :call
end
