class IpnController < ApplicationController

  include ActiveMerchant::Billing::Integrations
  require 'Crypto64'
  require 'money'


  def create
     @Person = Person.new()
     @Person.name="Create"+params[:invoice]
     @Person.email="andy@r2-dvd.org"
     @Person.login="andy"     
	status=""
	params.each do |key,value|
  		status=status<< "Param #{key}: #{value}	"
	end
	@Person.params=status
     FlockMailer.welcome_email(@Person).deliver

     ipn
  end


  def index
     @Person = Person.new()
     @Person.name="index"
     @Person.email="andy@r2-dvd.org"
     @Person.login="andy"     
     FlockMailer.welcome_email(@Person).deliver

  end

def ipn
  # Create a notify object we must
  notify = Paypal::Notification.new(request.raw_post)

  #we must make sure this transaction id is not allready completed
#  if !Trans.count("*", :conditions => ["paypal_transaction_id = ?", notify.transaction_id]).zero?
 #    # do some logging here...
#  end


  if notify.acknowledge
    begin
      if notify.complete?
         #transaction complete.. add your business logic here
     @Person = Person.new()
     @Person.name="Transaction complete"
     @Person.email="andy@r2-dvd.org"
     @Person.login="andy"
	status=""
	params.each do |key,value|
  		status=status<< "Param #{key}: #{value}	"
	end
	@Person.params=status

     FlockMailer.welcome_email(@Person).deliver



      else
         #Reason to be suspicious
    @Person = Person.new()
     @Person.name="Reason to be suspicous"+notify.item_id.to_s()+" "+notify.amount.to_s()

     @Person.email="andy@r2-dvd.org"
     @Person.login="andy"
	status=""
	params.each do |key,value|
  		status=status<< "Param #{key}: #{value}	"
	end
	@Person.params=status

     FlockMailer.welcome_email(@Person).deliver

      end

    rescue => e
      #Houston we have a bug
    ensure
      #make sure we logged everything we must
    end
  else #transaction was not acknowledged
    # another reason to be suspicious
  end

  render :nothing => true
end



end
