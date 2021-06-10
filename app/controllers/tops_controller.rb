class TopsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.create(contact_params)
    if @contact.save
      notifier = Slack::Notifier.new(
        ENV['WEBHOOK_URL'],
        channel: '#' + ENV['CHANNEL']
      )
      slack_message = "名前:#{@contact.name}\r\nアドレス：#{@contact.email}\r\n件名：#{@contact.title}"
      notifier.ping "【お問い合わせ】\r\n#{slack_message}"
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
