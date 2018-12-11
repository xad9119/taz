class BusinessAssetsController < ApplicationController
  before_action :set_business_asset, only: [:show, :edit, :update, :destroy]

def index
   if params[:query].present?
    sql_query = " \
    geographical_locations.address ILIKE :query \
    "
    @business_assets = policy_scope(BusinessAsset).joins(:geographical_location).where(
    sql_query, query: "%#{params[:query]}%")
    @markers = @business_assets.map do |business_asset|
      # next if business_asset.geographical_location.longitude.nil? || business_asset.geographical_location.latitude.nil?
      {
        title: business_asset.geographical_location.address,
        lng: business_asset.geographical_location.longitude,
        lat: business_asset.geographical_location.latitude,
        infoWindow: {content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: business_asset })}
      }
    end
    else
      @business_assets = policy_scope(BusinessAsset).order(created_at: :desc)
      @markers = @business_assets.map do |business_asset|
        next if business_asset.geographical_location.longitude.nil? || business_asset.geographical_location.latitude.nil?
        {
          title: business_asset.geographical_location.address,
          lng: business_asset.geographical_location.longitude,
          lat: business_asset.geographical_location.latitude,
          infoWindow: {content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: business_asset })}
        }
      end
      @markers.select! { |x| !x.nil? }
    end

    authorize @business_assets
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
    categories_array = [params['post']['category_ids'].map {|cat| cat.to_i}.drop(1)].flatten
    business_asset = BusinessAsset.new
    business_asset.define_attributes(my_hash,current_user)


    if business_asset.valid?
      business_asset.save!
      categories_array.each do |cat|
        binding.pry
        asset_category = AssetCategory.find(cat)
        BusinessAssetCategory.create(business_asset: business_asset, asset_category: asset_category)
      end

      # add a default picture that's the street view screenshot
      a = Attachment.new
      a.business_asset = business_asset
      a.attachment_type = 'photo'
      loc = business_asset.geographical_location
      url = "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=#{loc.latitude},#{loc.longitude}&fov=90&heading=235&pitch=10&key=#{ENV['GOOGLE_API_BROWSER_KEY']}"
      a.url = url
      a.remote_file_url = url
      a.save!

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

  def dashboard
    @buyers = Company.joins(:bought_transactions).distinct
    @buyers_unique = @buyers.all.select(:name).distinct
      if params[:option].present?
        @buyer = Company.find_by(name:params[:option])
      else
        @buyer = Company.find_by(name:"VLD")
      end

    @business_assets = policy_scope(BusinessAsset).joins(:last_transaction).where(transactions: { buyer_id: @buyer.id })
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

private
  def set_business_asset
    @business_asset = policy_scope(BusinessAsset).find(params[:id])
    authorize @business_asset
  end

  def nil_attributes? (class_instance)
    class_instance.attributes.values.select {|x| !x.nil? || x.nil? ? false : x.positive?}.empty?
  end
end
