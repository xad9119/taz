class BusinessAssetsController < ApplicationController
  before_action :set_business_asset, only: [:show, :edit, :update, :destroy]

  def index
    @business_assets = policy_scope(BusinessAsset).order(created_at: :desc)
    authorize @business_assets
    @markers = @business_assets.map do |business_asset|
      {
        lng: business_asset.geographical_location.longitude,
        lat: business_asset.geographical_location.latitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { business_asset: business_asset })
      }
    end
  end

  def show
  end

  def new
    @business_asset = BusinessAsset.new
    authorize @business_asset
  end

  def create
    raise
    latitude = params['search']['geographical_location']['latitude']
    longitude = params['search']['geographical_location']['longitude']
    @business_asset = BusinessAsset.new
    GeographicalLocation.create!(
      latitude: latitude,
      longitude: longitude
      )
    authorize @business_asset

    redirect_to business_assets_path

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
      :location_id,
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
end


