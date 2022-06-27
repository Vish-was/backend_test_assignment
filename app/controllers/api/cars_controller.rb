class Api::CarsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :set_user, only: [:index]

  def index
    @cars = Car.joins(:brand)
            .filter_by_model(name: filter_params[:query])
            .filter_by_price(filter_params[:price_min], filter_params[:price_max])
            .where("brand_id IN (?) ", @user.preferred_brand_ids)
    
    http_res = [{car_id: 186, rank_score: 25}]  ## mock api response
    response = CarBlueprint.render_as_json(@cars, response: http_res, user: @user, view: :api, root: :cars)
    render json: {data: response, msg: 'success'}, status: 200
  end

  private

  def set_user
    @user = User.includes(:preferred_brands).find(filter_params[:user_id])
  end

  def filter_params
    params.require(:car).permit(:user_id, :query, :price_min, :price_max, :page)
  end
end
