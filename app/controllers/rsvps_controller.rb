class RsvpsController < ApplicationController
  before_action :set_rsvp, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:new, :create]

  # GET /rsvps
  # GET /rsvps.json
  def index
    @rsvps = Rsvp.all
  end

  # GET /rsvps/1
  # GET /rsvps/1.json
  def show
  end

  # GET /rsvps/new
  def new
    @rsvp = Rsvp.new
  end

  # GET /rsvps/1/edit
  def edit
  end

  # POST /rsvps
  # POST /rsvps.json
  def create
    @rsvp = Rsvp.new(rsvp_params)

      if @rsvp.save
        redirect_to @rsvp, notice: 'Rsvp was successfully created.'
      else
        render action: 'new'
      end
  end

  # PATCH/PUT /rsvps/1
  # PATCH/PUT /rsvps/1.json
  def update
      if @rsvp.update(rsvp_params)
        redirect_to @rsvp, notice: 'Rsvp was successfully updated.'
      else
        render action: 'edit'
      end
  end

  # DELETE /rsvps/1
  # DELETE /rsvps/1.json
  def destroy
    @rsvp.destroy
    redirect_to rsvps_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsvp
      @rsvp = Rsvp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rsvp_params
      params.require(:rsvp).permit(:name, :contact, :attending, :party_size)
    end
end
