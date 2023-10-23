defmodule RubberDuckWeb.ServerStateLive.Show do
  use RubberDuckWeb, :live_view

  alias RubberDuck.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:server_state, Game.get_server_state!(id))}
  end

  defp page_title(:show), do: "Show Server state"
  defp page_title(:edit), do: "Edit Server state"
end
