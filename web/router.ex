defmodule TechForGoodHub.Router do
  use TechForGoodHub.Web, :router

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

  scope "/", TechForGoodHub do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/analysis", PageController, :analysis

    resources "/proposals", ProposalController
    get "/proposals/tagged/:slug", ProposalController, :tagged
    get "/proposals/filter/:tags", ProposalController, :filter
  end

  # Other scopes may use custom stacks.
  # scope "/api", TechForGoodHub do
  #   pipe_through :api
  # end
end
