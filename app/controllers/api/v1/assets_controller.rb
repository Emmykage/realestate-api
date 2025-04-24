class Api::V1::AssetsController < ApplicationController
  before_action :set_asset, only: %i[ show update destroy ]
  before_action :authorize, only: %i[ create ]

  # GET /assets
  def index
    @assets = Asset.all

    # @top_assets = @assets.order(created_at: :asc).first(3)


    # render json: {assets: @assets, recently_added: @top_assets}
    render json: {data:  ActiveModelSerializers::SerializableResource.new(@assets)}
  end

  # GET /assets/1
  def show
    render json: {data: AssetSerializer.new(@asset)}
  end

  # POST /assets
  def create
    @asset = Asset.new(asset_params)

    if @asset.save
      render json: {data: @asset}, status: :created
    else
      render json: {message:  @asset.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assets/1
  def update
    if @asset.update(asset_params)
      render json: {data: @asset}
    else
      render json:{message:  @asset.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end
  end

  # DELETE /assets/1
  def destroy
    @asset.destroy
    render json: {message: "Successfully deleted"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = Asset.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_params
      params.require(:asset).permit(
        :name,
        :address,
        :city,
        :tenure,
        :sale_type,
        :area,
        :number_of_bedrooms,
        :number_of_bathrooms,
        :price,
        :status,
        :asset_description,
        :description_body,
        :asset_category,
        :image,
        :property_type,
        :mainphoto,
        features: [],     # Array of strings
        photos: []        # Array of image URLs or uploads
      )
    end
end
