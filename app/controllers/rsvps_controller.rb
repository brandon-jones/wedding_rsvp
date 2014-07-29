class RsvpsController < ApplicationController
  before_action :set_rsvp, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:new, :create]
  skip_before_filter :verify_authenticity_token  

  # GET /rsvps
  # GET /rsvps.json
  def index
    if params[:sort_by] && params[:order_by]
      @rsvps = Rsvp.order("#{params[:sort_by]} #{params[:order_by]}")
    else
      @rsvps = Rsvp.all
    end
  end

  # GET /rsvps/1
  # GET /rsvps/1.json
  def show
  end

  # GET /rsvps/new
  def new
    @rsvp = Rsvp.new
    @default_value = 1
  end

  # GET /rsvps/1/edit
  def edit
    @default_value = @rsvp.party_size
  end

  # POST /rsvps
  # POST /rsvps.json
  def create
    @rsvp = Rsvp.new(rsvp_params)
    if @rsvp.attending == true && @rsvp.party_size < 1
      redirect_to new_rsvp_path, notice: 'Error please try again.'
    else
      if @rsvp.save
        if @rsvp.attending == false
          redirect_to root_path, notice: 'We are sorry you can not make it.'
        else
          redirect_to root_path, notice: 'We look forward to seeing you there.'
        end
      else
        render action: 'new'
      end
    end
  end

  # PATCH/PUT /rsvps/1
  # PATCH/PUT /rsvps/1.json
  def update
      if @rsvp.update(rsvp_params)
        redirect_to rsvps_path, notice: 'Rsvp was successfully updated.'
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
