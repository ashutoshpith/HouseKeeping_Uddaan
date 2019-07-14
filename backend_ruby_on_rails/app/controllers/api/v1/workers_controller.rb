module Api
  module V1
      class WorkersController < ApplicationController
        before_action :authorize_access_request!
        before_action :set_worker, only: [:show, :update, :destroy]

        # GET /workers
        def index
          @workers = Worker.all

          render json: @workers
        end

        # GET /workers/1
        def show
          render json: @worker
        end

        # POST /workers
        def create
          @worker = current_admin.workers.build(worker_params)

          if @worker.save
            render json: @worker, status: :created, location: api_v1_worker_url(@worker)
          else
            render json: @worker.errors, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /workers/1
        def update
          if @worker.update(worker_params)
            render json: @worker
          else
            render json: @worker.errors, status: :unprocessable_entity
          end
        end

        # DELETE /workers/1
        def destroy
          @worker.destroy
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_worker
            @worker = current_admin.workers.find(params[:id])
          end

          # Only allow a trusted parameter "white list" through.
          def worker_params
            params.require(:worker).permit(:name, :skill_set, :admin_id)
          end
      end
  end
end