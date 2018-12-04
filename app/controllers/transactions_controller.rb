class TransactionsController < ApplicationController
  def create
  end

  def update
  end

  def destroy
  end

  def compare
    @transactions = Transaction.all
    @transaction = Transaction.find(params[:id])
    @asset = @transaction.asset
    @rental = @asset.rentals
                    .select { |r| !r.end_date || (r.start_date <= Date.today && Date.today <= r.end_date) }
                    .first
  end
end
