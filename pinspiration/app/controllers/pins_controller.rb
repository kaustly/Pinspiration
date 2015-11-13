class PinsController < ApplicationController

  def new
    @pin = Pin.new
  end

  def show
    @pin = Pin.find(params[:id])
  end
  
  def index
    @pins = Pin.all
  end

  def create
    @pin = Pin.new(pin_params)

    if @pin.save
      redirect_to @pin
    else
      render "new"
    end
  end


    def edit
      @pin = Pin.find(params[:id])
    end

    def update
      @pin = Pin.find(params[:id])

      if @pin.update(pin_params)
        redirect_to @pin
      else
        render "edit"
      end
    end

    def destroy
      @pin = Pin.find(params[:id])
      @pin.destroy

      redirect_to pins_path
    end
  private
  def pin_params
    params.require(:pin).permit(:title, :image_url)
  end
end
