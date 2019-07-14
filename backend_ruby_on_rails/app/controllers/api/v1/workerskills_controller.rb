module Api
  module V1
      class WorkerskillsController < ApplicationController
        before_action :authorize_access_request!

        before_action :set_workerskill, only: [:show, :update, :destroy]

        # GET /workerskills
        def index
          @workerskills = Workerskill.all

          render json: @workerskills
        end

        # GET /workerskills/1
        def show
          render json: @workerskill
        end

        # POST /workerskills
        def create
          @workerskill = Workerskill.new(workerskill_params)

          if @workerskill.save
            render json: @workerskill, status: :created, location: api_v1_workerskill_url(@workerskill)
          else
            render json: @workerskill.errors, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /workerskills/1
        def update
          if @workerskill.update(workerskill_params)
            render json: @workerskill
          else
            render json: @workerskill.errors, status: :unprocessable_entity
          end
        end

        # DELETE /workerskills/1
        def destroy
          @workerskill.destroy
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_workerskill
            @workerskill = Workerskill.find(params[:id])
          end

          # Only allow a trusted parameter "white list" through.
          def workerskill_params
            params.require(:workerskill).permit(:name, :skill_set)
          end
      end
    end
  end