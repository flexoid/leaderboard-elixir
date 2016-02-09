defmodule Leaderboard.Router do
  use Leaderboard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Leaderboard do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api/projects/:project_id/events/:event_id", Leaderboard.Api do
    pipe_through :api

    get "/records/:user_id", RecordController, :show
    post "/records", RecordController, :update
  end
end
