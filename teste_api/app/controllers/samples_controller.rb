class SamplesController < ApplicationController
  before_action :set_sample, only: [:show, :update, :destroy]

  # GET /samples
  def index
    @samples = Sample.all

    render json: @samples
  end

  # GET /samples/1
  def show
    render json: @sample
  end

  # POST /samples
  def create
    @sample = Sample.new(sample_params)

    if @sample.save
      render json: @sample, status: :created, location: @sample
    else
      render json: @sample.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /samples/1
  def update
    if @sample.update(sample_params)
      render json: @sample
    else
      render json: @sample.errors, status: :unprocessable_entity
    end
  end

  # DELETE /samples/1
  def destroy
    @sample.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sample
      @sample = Sample.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sample_params
      params.require(:sample).permit(:data)
    end
end
