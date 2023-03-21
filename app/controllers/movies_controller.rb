class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    movies = Movie.all
    render json: movies
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie
  end
  def summary
    movie = Movie.find(params[:id])
    render json: movie, serializer: MovieSummarySerializer
  end
  def summaries
    movies = Movie.all
    render json: movies, each_serializer: MovieSummarySerializer
  end

  private

  def render_not_found_response
    render json: { error: "Movie not found" }, status: :not_found
  end
end

# The work of the controller is to interact with the model to access whatever data is requested and then pass that data along to the View layer
# Views are responsible for determining exactly how the information is presented to the user.
# ActiveModel: :Serializer provides a way to customize how the JSON rendered by our controllers is structured. Allows for separation of concerns

