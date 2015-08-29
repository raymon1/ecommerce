class ContactsController < ApplicationController
	def new
	end

	def create
		contact = Contact.create(contact_params)

		redirect_to '/contacts'
	end

	private
	def contact_params
		params.require(:contact).permit(:name, :email, :message)
	end
end
