class GuestbooksController < ApplicationController
  before_action :set_guestbook, only: [:show, :edit, :destroy]
  before_action :authenticate, except: [:index, :flag, :create]

  # GET /guestbooks
  # GET /guestbooks.json
  def index
    @guestbooks = Guestbook.all.reverse_order.page params[:page]
    @guestbook = Guestbook.new
  end

  # GET /guestbooks/new
  def new
    @guestbook = Guestbook.new
  end

  def export
    @guestbook = Guestbook.all.reverse_order
    Guestbook.generate_pdf
    # send_file "tmp/pdf/export.pdf", :type=>'text/pdf'
    redirect_to manage_guestbooks_path
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

      if @guestbook.save
        redirect_to guestbooks_path, notice: 'Thank you for leaving a message.'
      else
        render action: 'new'
      end
  end

  # DELETE /guestbooks/1
  # DELETE /guestbooks/1.json
  def destroy
    @guestbook.destroy
    redirect_to manage_guestbooks_path
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
