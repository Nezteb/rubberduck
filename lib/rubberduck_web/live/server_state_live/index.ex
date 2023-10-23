defmodule RubberDuckWeb.ServerStateLive.Index do
  use RubberDuckWeb, :live_view

  alias RubberDuck.Game
  alias RubberDuck.Game.ServerState

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :server_states, Game.list_server_states())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Server state")
    |> assign(:server_state, Game.get_server_state!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Server state")
    |> assign(:server_state, %ServerState{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Server states")
    |> assign(:server_state, nil)
  end

  @impl true
  def handle_info({RubberDuckWeb.ServerStateLive.FormComponent, {:saved, server_state}}, socket) do
    {:noreply, stream_insert(socket, :server_states, server_state)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    server_state = Game.get_server_state!(id)
    {:ok, _} = Game.delete_server_state(server_state)

    {:noreply, stream_delete(socket, :server_states, server_state)}
  end
end
