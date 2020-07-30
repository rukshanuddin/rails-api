module V1
class LinksController < ApiController
  def index
    render json: Link.all
  end
  def show 
    render json: Link.where(id: params[:id]).to_json
  end
end
end