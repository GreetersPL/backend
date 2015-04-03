module Api
  module V1
    # Singup api controller
    class SignupsController < Api::V1Controller
      before_action :set_application, only: [:show, :edit, :update, :destroy]

      # GET /applications
      def index
        @applications = Application.all
      end

      # GET /applications/1
      def show
      end

      # GET /applications/new
      def new
        @application = Application.new
      end

      # GET /applications/1/edit
      def edit
      end

      # POST /applications
      def create
        @signup = Signup.new(signup_params)
        @signup.save
        respond_with @signup, location: '', only: [:id, :name, :email, :age, :activity, :source, :expect, :why, :places, :languages, :created_at]
      end

      # PATCH/PUT /applications/1
      def update
        if @application.update(application_params)
          redirect_to @application, notice: 'Application was successfully updated.'
        else
          render :edit
        end
      end

      # DELETE /applications/1
      def destroy
        @application.destroy
        redirect_to applications_url, notice: 'Application was successfully destroyed.'
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_application
        @application = Application.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def signup_params
        params[:signup].permit(:name, :email, :age, :activity, :source, :expect, :why, :places, :user_lang, languages: [:language, :level])
      end
    end
  end
end
