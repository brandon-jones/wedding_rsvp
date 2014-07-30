class RsvpsController < ApplicationController
  before_action :set_rsvp, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:new, :create]
  skip_before_filter :verify_authenticity_token  

  # GET /rsvps
  # GET /rsvps.json
  def index

    if params[:show]
      @show = params[:show]
      case @show
        when 'all'
          @rsvps = Rsvp.all
        when 'only_going'
          @rsvps = Rsvp.where(attending: true)
        when 'only_not_going'
          @rsvps = Rsvp.where(attending: false)
        else
          @rsvps = Rsvp.all
      end
    else
      @rsvps = Rsvp.all
    end
    if params[:sort_by] && params[:order_by]
      @rsvps = @rsvps.order("#{params[:sort_by].gsub(' ','_')} #{params[:order_by]}")
    end

    # if params[:js] == true
    #   @partial = true
    # else
    #   @partial = false
    # end

    if params[:js] == 'true'
      return render partial: 'rsvp_list'
    end


    @total_count = Rsvp.where(attending: true).sum(:party_size)
    @party_count = Rsvp.where(attending: true).count
  end

  # GET /rsvps/1
  # GET /rsvps/1.json
  def show
  end

  def export
    if params[:show]
      case params[:show]
      when 'all'
        @rsvp_for_export = Rsvp.all
      when 'only_going'
        @rsvp_for_export = Rsvp.where(attending: true)
      when 'only_not_going'
        @rsvp_for_export = Rsvp.where(attending: false)
      end
    end

    if params[:sort_by] && params[:order_by]
      @rsvp_for_export = @rsvp_for_export.order("#{params[:sort_by]} #{params[:order_by]}")
    elsif params[:sort_by]
      @rsvp_for_export = @rsvp_for_export.order("#{params[:sort_by]}")
    end

    if params[:extension]
      if params[:extension] == 'csv'
        binding.pry
        render text: @rsvp_for_export.to_csv
      end
    end

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
