class AmazonsController < ApplicationController
  # GET /amazons
  # GET /amazons.xml
  def index
    @amazons = Amazon.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @amazons }
    end
  end

  # GET /amazons/1
  # GET /amazons/1.xml
  def show
    @amazon = Amazon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @amazon }
    end
  end

  # GET /amazons/new
  # GET /amazons/new.xml
  def new
    @amazon = Amazon.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @amazon }
    end
  end

  # GET /amazons/1/edit
  def edit
    @amazon = Amazon.find(params[:id])
  end

  # POST /amazons
  # POST /amazons.xml
  def create
    @amazon = Amazon.new(params[:amazon])

    respond_to do |format|
      if @amazon.save
        format.html { redirect_to(@amazon, :notice => 'Amazon was successfully created.') }
        format.xml  { render :xml => @amazon, :status => :created, :location => @amazon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @amazon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /amazons/1
  # PUT /amazons/1.xml
  def update
    @amazon = Amazon.find(params[:id])

    respond_to do |format|
      if @amazon.update_attributes(params[:amazon])
        format.html { redirect_to(@amazon, :notice => 'Amazon was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @amazon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /amazons/1
  # DELETE /amazons/1.xml
  def destroy
    @amazon = Amazon.find(params[:id])
    @amazon.destroy

    respond_to do |format|
      format.html { redirect_to(amazons_url) }
      format.xml  { head :ok }
    end
  end
end
