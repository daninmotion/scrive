class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /pages
  # GET /pages.json
  def index
    @pages = current_user.pages.order(created_at: :desc) #for the current signed in user
    query = params[:q].presence || "*"
    @pages = current_user.pages.search(query)
    @pages = current_user.pages.paginate(:page => params[:page], :per_page => 5)
  end


  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = current_user.pages.find(params[:id])
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
    @page = current_user.pages.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = current_user.pages.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to root_path, notice: 'Page was successfully created.' }
        format.json { render json: { action: "/pages/#{@page.id}", method: 'put'}, status: :ok }
        format.js { render }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def autocomplete
    render json: Page.search(params[:term], fields: [{body: :text_start}], limit: 10).map(&:body)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:body)
    end
end
