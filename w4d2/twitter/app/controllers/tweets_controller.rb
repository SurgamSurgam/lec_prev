class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order('updated_at DESC').includes(:user)

    # render json: tweets
    render :index
  end

  def new
    @tweet = Tweet.new

    render :new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user = User.all.sample # probably not what you want to do

    if tweet.save
      redirect_to tweets_url
    else
      render json: tweet.errors, status: 422 # unprocessable entity
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])

    render :edit
  end

  def update
    @tweet = Tweet.find(params[:id])

    if @tweet.update(tweet_params)
      redirect_to tweets_url
    else
      render json: @tweet.errors, status: 422
    end
  end

  private

  def tweet_params
    # params: { tweet: { body: "love wins"} }
    params.require(:tweet).permit(:body)
  end
end
