class BusinessAssetsController < ApplicationController
  before_action :set_business_asset, only: [:show, :edit, :update, :destroy]

def index
   if params[:query].present?

     sql_query = " \
     geographical_locations.address ILIKE :query \
     "
     @business_assets = policy_scope(BusinessAsset).joins(:geographical_location).where(
       sql_query, query: "%#{params[:query]}%")
     else
      @business_assets = policy_scope(BusinessAsset).order(created_at: :desc)
    end
      authorize @business_assets

      @markers = @business_assets.map do |business_asset|
        next if business_asset.geographical_location.longitude.nil? || business_asset.geographical_location.latitude.nil?
        {
          title: business_asset.geographical_location.address,
          lng: business_asset.geographical_location.longitude,
          lat: business_asset.geographical_location.latitude,
          infoWindow: {content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: business_asset })}
        }
      end.compact!

  end

  def show
    @markers =
      {
        title: @business_asset.geographical_location.address,
        lng: @business_asset.geographical_location.longitude,
        lat: @business_asset.geographical_location.latitude,
        infoWindow: {content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: @business_asset })}
      }
  end

  def new
    @business_asset = BusinessAsset.new
    authorize @business_asset
  end

  def create
    my_hash = params['search']

    business_asset = BusinessAsset.new
    business_asset.define_attributes(my_hash, current_user)
    if business_asset.valid?
      business_asset.save!
    else
      flash[:alert] = business_asset.errors.full_messages
      render :new
    end

    rental = Rental.new
    rental.define_attributes(my_hash['rentals'], business_asset)
    if rental.valid?
      rental.save!
    elsif nil_attributes?(rental) == false
      flash[:alert] = rental.errors.full_messages
      render :new
    end


    transaction = Transaction.new
    transaction.define_attributes(my_hash['transactions'], business_asset)
    if transaction.valid?
        transaction.save!
    elsif nil_attributes?(transaction) == false
      flash[:alert] = transaction.errors.full_messages
      render :new
    end

    if business_asset.valid?
      redirect_to business_asset_path(business_asset)
    end

    authorize business_asset
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
  def set_business_asset
    @business_asset = policy_scope(BusinessAsset).find(params[:id])
    authorize @business_asset
  end

  def business_asset_params
    params.require(:business_asset).permit(
      :user_id,
      # :geographical_location_attributes: {...},
      :business_asset_manager_id,
      :construction_year,
      :has_icpe,
      :business_asset_type,
      :occupancy_rate,
      :office_area_share,
      :potential_annual_rent,
      :potential_annual_rent_sqm,
      :height,
      :land_surface,
      :surface,
      :general_condition,
      :description
      )
  end

  def nil_attributes? (class_instance)
    class_instance.attributes.values.select {|x| !x.nil? || x.nil? ? false : x.positive?}.empty?
  end
end


