class Deposit < ApplicationRecord
  belongs_to :address, optional: true
  belongs_to :asset
  belongs_to :user
  has_one :balance_adjustment, as: :change

  belongs_to :withdrawal_to_hotwallet, class_name: 'Withdrawal', optional: true

  before_validation do
    self.user ||= address.user
    self.balance_adjustment ||= BalanceAdjustment.new({user: user, asset: asset, amount: amount})
  end

  after_create do
    UserMailer.with(user: user, deposit: self).deposit_email.deliver_later
  end

  def tx_url
    asset.platform.tx_url(transaction_id)
  end
end
