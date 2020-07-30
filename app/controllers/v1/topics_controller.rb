module V1
class TopicsController < ApiController
  def index
    render json: Topic.all.to_json
  end
  def show 
    render json: Link.where(topic_id: params[:id]).to_json
  end
end
end