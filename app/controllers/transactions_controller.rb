class TransactionsController < ApplicationController
  skip_after_action :verify_policy_scoped, :only => :compare

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
    @comparables = @transaction.ranked_comparables

    if params[:query]
      @key_comparables = @comparables.select { |e| params[:query].split(' ').include?(e.id.to_s) }
    else
      @key_comparables = @comparables.first(5)
      query = @comparables.first(5).map(&:id).join(' ')
      redirect_to compare_path(params[:id], query: query) and return
    end

    @fair_price = @transaction.fair_price(@key_comparables)

    @markers = @key_comparables.map do |tr|
      {
        title: tr.business_asset.geographical_location.address,
        lng: tr.business_asset.geographical_location.longitude,
        lat: tr.business_asset.geographical_location.latitude,
        infoWindow: { content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: tr.business_asset }) }
      }
    end
  end
end
