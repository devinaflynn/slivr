class PinMostViewsController < ApplicationController
  def index
    @random_model = Pin.order('random()').first
    @pins = Pin.top_viewed(params[:page], params[:date])
  end

  def pin_most_views_params
    params.require(:pin).permit(:ip_address, :visit_id)
  end

end
