class BusinessAssetsController < ApplicationController
  before_action :set_business_asset, only: [:show, :edit, :update, :destroy]

  def index
    @business_assets = policy_scope(BusinessAsset).order(created_at: :desc)
  end

  def show
  end

  def new
  end

  def create
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


