class TransactionsController < ApplicationController
  def create
  end

  def update
  end

  def destroy
  end

  def compare
    @transactions = policy_scope(Transaction)
    @transaction = policy_scope(Transaction).find(params[:id])
    @business_asset = @transaction.business_asset
    @rental = @business_asset.rentals
                    .select { |r| !r.end_date || (r.start_date <= Date.today && Date.today <= r.end_date) }
                    .first
    @comparables = (1..15).to_a.map { |_| @transaction }
  end
end
