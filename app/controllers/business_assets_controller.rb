class BusinessAssetsController < ApplicationController
  before_action :set_business_asset, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only:  [:search, :destroy]

def search
    @business_assets = policy_scope(BusinessAsset)
    .joins(:geographical_location)
    # .joins(:business_asset_category)
    # .joins(:asset_category)

      my_hash = params["search"]
      categories_array = [params['post']['category_ids'].map {|cat| cat.to_i}.drop(1)].flatten
      .map{|cat| AssetCategory.find(cat).name}
      if !my_hash["address"].empty?
        sql_query = " \
        geographical_locations.address ILIKE :query \
        "
        @business_assets = @business_assets
        .where(sql_query, query: "%#{my_hash["address"] }%")

      end

      unless categories_array.empty?
        @business_assets = @business_assets.where(asset_type: categories_array)

        # .where("asset_type LIKE ?", "%#{params[:asset_category]}%")
        # sql_query = " \
        # business_assets.asset_type ILIKE :asset_category \
        # "
        # @business_assets = @business_assets
        # .where(sql_query, query: "%#{params[:asset_category] }%")

      end


    @markers = @business_assets.map do |business_asset|
      # next if business_asset.geographical_location.longitude.nil? || business_asset.geographical_location.latitude.nil?
      {
        title: business_asset.geographical_location.address,
        lng: business_asset.geographical_location.longitude,
        lat: business_asset.geographical_location.latitude,
        infoWindow: {content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: business_asset })}
      }
    end
    @markers.select! { |x| !x.nil? }
    respond_to do |format|
      format.js
    end

end

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
          infoWindow: {content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: business_asset })},
          icon: ActionController::Base.helpers.image_path("#{business_asset.asset_type.downcase.delete(' ')}.png")
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
            infoWindow: {content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: business_asset })},
            # icon: image_tag("lynx.jpg", size: "10x10")
            icon: ActionController::Base.helpers.image_path("#{business_asset.asset_type.downcase.delete(' ')}.png")
          }
        end
        @markers.select! { |x| !x.nil? }
        @business_assets.limit(20)
    end
    authorize @business_assets
  end

  def show
    @markers =
      {
        title: @business_asset.geographical_location.address,
        lng: @business_asset.geographical_location.longitude,
        lat: @business_asset.geographical_location.latitude,
        infoWindow: {content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: @business_asset })},
        icon: ActionController::Base.helpers.image_path("#{@business_asset.asset_type.downcase.delete(' ')}.png")
      }
    ap @business_asset.attachments
    @carroussel = @business_asset.attachments.sort_by { |file| file.id }
    ap @carroussel
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
      business_asset.asset_type = AssetCategory.find(categories_array.first.to_i).name if !categories_array.empty?
      business_asset.save!
      categories_array.each do |cat|
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

    attachment = Attachment.new(business_asset: business_asset)
    if my_hash[:attachment]
    file = my_hash[:attachment][:file]
    attachment.file = file
    end
    attachment.save

    authorize business_asset
  end

  # redirect_to business_assets_path


  def edit
  end

  def update
  end

  def destroy
    respond_to do |format|
    format.html
    format.js
    end
    # @business_asset = BusinessAsset.find(params[:id])
    @business_asset.destroy
    redirect_to business_assets_path
  end

  def dashboard
    authorize policy_scope(BusinessAsset)
    @buyers_unique = Company.joins(:bought_transactions).select(:name).distinct
    if params[:option].present?
      @buyer = Company.find_by(name: params[:option])
    else
      @buyer = Company.find_by(name: "VLD")
    end
    last_transactions = BusinessAsset.all.map { |business_asset| business_asset.last_transaction }
    buyer_last_transactions = last_transactions.select { |transaction| transaction.buyer == @buyer }
    @business_assets = buyer_last_transactions.map { |buyer_last_transaction| buyer_last_transaction.business_asset }
                                              .sort_by {|b| b.rentals.last.annual_rent }
                                              .reverse
    @max_price = @business_assets.map { |bus| bus.transactions.last.price }.max()
    @markers = @business_assets.map do |business_asset|
        next if business_asset.geographical_location.longitude.nil? || business_asset.geographical_location.latitude.nil?
        {
          title: business_asset.geographical_location.address,
          lng: business_asset.geographical_location.longitude,
          lat: business_asset.geographical_location.latitude,
          infoWindow: {content: render_to_string(partial: "/business_assets/infowindow", locals: { business_asset: business_asset })}
        }
      end
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
