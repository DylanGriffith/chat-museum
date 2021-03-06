class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_approved

  def search
    @results = Message.search(params[:q]).limit(100)
  end

  def show
    @message = Message.find(params[:id])
  end
end
