# frozen_string_literal: true
class SitesController < ApplicationController
  before_action :set_site, only: %i[show update destroy]
  before_action :authenticate_user!

  # GET /sites
  def index
    @sites = Site.all

    render json: @sites
  end

  # GET /sites/1
  def show
    reference_date = "2018-06-20".to_date
    number_days_back = 5
    past_thi_array = HistoricalThi.new(@site, number_days_back, reference_date).perform
    render json: {site: @site, historical_thi: past_thi_array}
  end

  # POST /sites
  def create
    @site = Site.new(site_params)

    if @site.save
      render json: @site, status: :created, location: @site
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sites/1
  def update
    if @site.update(site_params)
      render json: @site
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sites/1
  def destroy
    @site.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_site
    @site = Site.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def site_params
    params.fetch(:site, {})
  end
end
