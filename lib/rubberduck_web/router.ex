defmodule RubberduckWeb.Router do
  use RubberduckWeb, :router

  alias RubberduckWeb.ServerStateLive.Index, as: ServerStateLive

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RubberduckWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RubberduckWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/server_states", ServerStateLive, :index
    live "/server_states/new", ServerStateLive, :new
    live "/server_states/:id/edit", ServerStateLive, :edit

    live "/server_states/:id", ServerStateLive, :show
    live "/server_states/:id/show/edit", ServerStateLive, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", RubberduckWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:rubberduck, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RubberduckWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
