class EventsController < ApplicationController



  include ActiveMerchant::Billing::Integrations
  require 'Crypto64'
  require 'money'



  before_filter :authenticate

  # GET /events
  # GET /events.xml
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
#lets add a temp email event if :done is descovered.

     @Person = Person.new()
     @Person.name="events.show"
     @Person.email="andy@r2-dvd.org"
     @Person.login="andy"     
	status=""
	params.each do |key,value|
  		status=status<< "Param #{key}: #{value}	"
	end
	@Person.params=status
     FlockMailer.welcome_email(@Person).deliver




    fetch_decrypted(@event)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end


  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Buying credits for fun?"
    redirect_to :action => "profile"
  end



private
  def fetch_decrypted(event = nil)

    # cert_id is the certificate if we see in paypal when we upload our own certificates
    # cmd _xclick need for buttons
    # item name is what the user will see at the paypal page
    # custom and invoice are passthrough vars which we will get back with the asunchronous
    # notification
    # no_note and no_shipping means the client want see these extra fields on the paypal payment
    # page
    # return is the url the user will be redirected to by paypal when the transaction is completed.
    decrypted = {
      "cert_id" => "HBALH6UNXEKN2",
      "cmd" => "_xclick",
      "business" => "andy-r2-test@r2-dvd.org",
      "item_name" => "Event_" +event.title,
      "item_number" => "i"+(event.id+1000).to_s(),
      "custom" =>"Invoice"+(event.id+1000).to_s(),
      "amount" => "10",
      "currency_code" => "USD",
      "country" => "UK",
      "no_note" => "1",
      "no_shipping" => "1",
    }

    if event
      decrypted.merge!("invoice" => "ID"+(event.id+1000).to_s(), "return" => "http://ruby.r2-dvd.org/event/done/#{event.id}")
    else
      decrypted.merge!("return" => "http://ruby.r2-dvd.org/event/done")
    end

    @encrypted_basic = Crypto64::Button.from_hash(decrypted).get_encrypted_text
    @action_url = ENV['RAILS_ENV'] == "production" ? "https://www.paypal.com/uk/cgi-bin/webscr" : "https://www.sandbox.paypal.com/uk/cgi-bin/webscr"
end


