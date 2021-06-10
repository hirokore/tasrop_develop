class TopsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.create(contact_params)
    if @contact.save
      redirect_to new_top_path, notice: "受付完了"
    else
      render :new
    end 
  end

  def contact
    @contact = Contact.new
  end

  def tutorial
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content, :title)
  end
  
end
