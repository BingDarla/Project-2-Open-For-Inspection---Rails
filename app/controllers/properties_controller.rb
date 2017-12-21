class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    # @properties = Property.all('date')  ## Who put this in? What is ('date') intended to do ?
    @properties = Property.all
    respond_to do |format|
      format.html {} # do nothing - this is the default. display as normal html
      format.json {render :json => @properties}
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    property = Property.find params[:id]
    respond_to do |format|
      format.html {}
      format.json { render :json => property}
    end
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
      # respond_to do |format|
      #   if @property.update(property_params)
      #     format.html { redirect_to @property, notice: 'Property was successfully updated.' }
      #     format.json { render :show, status: :ok, location: @property }
      #   else
      #     format.html { render :edit }
      #     format.json { render json: @property.errors, status: :unprocessable_entity }
      #   end
      # end
    property = Property.find params[:id]
    # raise
    if params["property"]["photo"].nil?
      property.update property_params
    else
      cloudinary = Cloudinary::Uploader.upload( params[ "property" ][ "photo" ] )
      # link = cloudinary["url"]
      # raise
      # property.update :photo => link
      # property.update :photo => cloudinary["url"]  # JOSH FIX
      property.photo = cloudinary["url"] #John Original Code


    end
    # raise
    property.update property_params #John Original Code
    redirect_to property

  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      #params.fetch(:property, {})
      params.require(:property).permit(:address, :suburb, :landsize, :bedrooms, :bathrooms, :private_parking, :expected_price)
    end
end
