class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :authorize, only: [:new , :create]
  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all
  end

  # GET /urls/1
  # GET /urls/1.json
  # def show
  # end

  # GET /urls/new
  def new
    @url = Url.new
  end

  def go
     @url = Url.find_by(short_url: params[:short_url])
    if @url 
      @url.clicks += 1
      @url.save
      redirect_to @url.full_url
    else
      redirect_to '/'
    end  
  end  

  # GET /urls/1/edit
  # def edit
  # end

  def favorite
    if @url.user_favorites.include?(current_user)   
      temp = @url.favorites.where(user_id: current_user.id)
      temp.first.destroy
      flash[:error] = "Favorite removed!"
    else
      @url.user_favorites << current_user
      flash[:success] = "Favorite added!"
    end  
   redirect_to "/"
  end  

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)
    @url.creator = current_user
    @url.short_url = Url.get_short_url
      if @url.save
        redirect_to "/"
      else
        redirect_to "urls/new"
      end
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  # def update
  #   respond_to do |format|
  #     if @url.update(url_params)
  #       format.html { redirect_to @url, notice: 'Url was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @url }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @url.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    if @url.creator = current_user
      @url.destroy
      respond_to do |format|
        format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
        format.json { head :no_content }
      end
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:description, :full_url, :short_url, :clicks, :user_id)
    end
end
