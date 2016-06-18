class RequestsController < ApplicationController
  def index
    #@requests = Requests.where(delete_flg: false)
    @requests = Request.all
  end

  def new
  end

  def edit
  end

  def delete
  end
end
