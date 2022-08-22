class NoticesController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_notice, only: %i[ show update destroy ]

  # GET /notices
  def index
    if current_user
      @notices = Notice.all
      render json: @notices
    else
    render json: { message: "Login first to access this page."}, status: :unprocessable_entity
    end
  end

  # GET /notices/1
  def show
    render json: @notice
  end

  # POST /notices
  def create

    if current_user
      @notice = Notice.new(notice_params)
      @notice.user_id=current_user.id

          if @notice.save
            render json: @notice, status: :created, location: @notice
          else
            render json: @notice.errors, status: :unprocessable_entity
          end
    else
    render json: { message: "Login first to access this page."}, status: :unprocessable_entity
    end

    # @notice = Notice.new(notice_params)

    # if @notice.save
    #   render json: @notice, status: :created, location: @notice
    # else
    #   render json: @notice.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /notices/1
  def update
    if @notice.update(notice_params)
      render json: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notices/1
  def destroy
    @notice.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notice_params
      # params.fetch(:notice, {})
      params.require(:notice).permit(:title, :discription)

    end
end
