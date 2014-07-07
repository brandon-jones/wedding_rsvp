class GuestbooksController < ApplicationController
  before_action :set_guestbook, only: [:show, :edit, :destroy]
  http_basic_authenticate_with name: "dhh", password: "secret", only: :manage
  # GET /guestbooks
  # GET /guestbooks.json
  def index
    @guestbooks = Guestbook.all.reverse_order.page params[:page]
    @guestbook = Guestbook.new
  end

  # GET /guestbooks/1
  # GET /guestbooks/1.json
  def show
  end

  # GET /guestbooks/new
  def new
    @guestbook = Guestbook.new
  end

  # GET /guestbooks/1/edit
  def edit
  end

  def flag
    guestbook = Guestbook.find(params[:id])
    guestbook.flag = true
    if guestbook.save
      FlaggedGuestbook.flagged_notifier.deliver
    end
    return redirect_to( guestbooks_path )
  end

  def manage
    @guestbooks = Guestbook.all.reverse_order.page params[:page]
    @flagged = Guestbook.where(flag: true).reverse_order
  end

  def approve
    if params[:id]
      entry = Guestbook.find params[:id]
      entry.flag = false
      entry.save
    end
    redirect_to manage_guestbooks_path
  end

  # POST /guestbooks
  # POST /guestbooks.json
  def create
    @guestbook = Guestbook.new(guestbook_params)

    respond_to do |format|
      if @guestbook.save
        format.html { redirect_to guestbooks_path, notice: 'Message was left.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # DELETE /guestbooks/1
  # DELETE /guestbooks/1.json
  def destroy
    @guestbook.destroy
    respond_to do |format|
      format.html { redirect_to manage_guestbooks_path }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guestbook
      @guestbook = Guestbook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guestbook_params
      params.require(:guestbook).permit(:name, :message)
    end
end
