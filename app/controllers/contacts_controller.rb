class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(params[:contact])
		@contact.request = request
			@object = @contact

		if @contact.deliver
			flash.now[:notice] = 'Thank you for your message! I try to respond within 24hrs so you should hear from me soon.'
			render 'thanks'
		else
			flash.now[:error] = 'Unable to send message.'
			render 'new'
		end
	end

	def thanks
	end


end