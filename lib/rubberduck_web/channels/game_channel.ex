defmodule RubberduckWeb.GameChannel do
  use RubberduckWeb, :channel

  # alias Rubberduck.Game.ServerState

  @impl true
  def join("game:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (game:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_in("action", %{"action" => _action}, socket) do
    # Apply the action on the server
    # ServerState.apply_action(action)

    # Broadcast the new state to all clients
    # broadcast!(socket, "new_state", %{"state" => ServerState.get_state()})

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
