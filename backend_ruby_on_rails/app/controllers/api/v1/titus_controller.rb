 module Api
  module V1  
 class TitusController < ApplicationController
  before_action :set_titu, only: [:show, :update, :destroy]

  # GET /titus
  def index
    @titus = Titu.all

    render json: @titus
  end

  # GET /titus/1
  def show
    render json: @titu
  end

  # POST /titus
  def create
    @titu = Titu.new(titu_params)

    if @titu.save
      render json: @titu, status: :created, location: @titu
    else
      render json: @titu.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /titus/1
  def update
    if @titu.update(titu_params)
      render json: @titu
    else
      render json: @titu.errors, status: :unprocessable_entity
    end
  end

  # DELETE /titus/1
  def destroy
    @titu.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_titu
      @titu = Titu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def titu_params
      params.require(:titu).permit(:name, :age)
    end
end

  end
end