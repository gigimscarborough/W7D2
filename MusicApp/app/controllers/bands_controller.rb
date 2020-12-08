class BandsController < ApplicationController
  def index
    @bands = Band.all
    
    render :index
  end

  def new
    @band = Band.new

    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to bands_url
    else
      flash[:errors] = ["Really? A band with no name dummy?"]
      render :new
    end
  end

  def show
    @band - Band.find(params[:id])
    render :show
  end

  def edit
    @band - Band.find(params[:id])
    render :edit
  end
  
  def update
    @band = Band.find(params[:id])

    if @band.update!(band_params)
      redirect_to bands_url
    else
      flash[:errors] = ["Today is not your day... Yikes!"]
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    
    @band.destroy
  end

  private
  
  def band_params
    params.require(:band).permit(:name)
  end
end
