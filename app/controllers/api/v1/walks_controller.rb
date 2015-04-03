module Api
  module V1
    # Walk api controller
    class WalksController < Api::V1Controller
      before_action :set_walk, only: [:show, :edit, :update, :destroy]

      # GET /walks
      def index
        @walks = Walk.all
      end

      # GET /walks/1
      def show
      end

      # GET /walks/new
      def new
        @walk = Walk.new
      end

      # GET /walks/1/edit
      def edit
      end

      # POST /walks
      def create
        @walk = Walk.new(walk_params)
        @walk.save
        respond_with @walk, location: '', only: [:id, :name, :email, :dates, :languages, :created_at]
      end

      # PATCH/PUT /walks/1
      def update
        if @walk.update(walk_params)
          redirect_to @walk, notice: 'Walk was successfully updated.'
        else
          render :edit
        end
      end

      # DELETE /walks/1
      def destroy
        @walk.destroy
        redirect_to walks_url, notice: 'Walk was successfully destroyed.'
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_walk
        @walk = Walk.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def walk_params
        params[:walk].permit(:name, :email, :user_lang, dates: [:date, :from, :to], languages: [:language, :level])
      end
    end
  end
end
