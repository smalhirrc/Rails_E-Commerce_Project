class PagesController < ApplicationController
  def index
  end

  def show
    @page = Page.find_by!(slug: params[:slug])
  end
end
