defmodule ErlportDemoWeb.Router do
  use ErlportDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ErlportDemoWeb do
    pipe_through :browser

    get  "/",       PageController,   :index
    get  "/train",  PageController,   :train
    get  "/guess",  PageController,   :guess
    post "/oracle", OracleController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ErlportDemoWeb do
  #   pipe_through :api
  # end
end
