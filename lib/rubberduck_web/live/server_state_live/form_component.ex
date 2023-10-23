defmodule RubberDuckWeb.ServerStateLive.FormComponent do
  use RubberDuckWeb, :live_component

  alias RubberDuck.Game

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage server_state records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="server_state-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:value]} type="number" label="Value" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Server state</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{server_state: server_state} = assigns, socket) do
    changeset = Game.change_server_state(server_state)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"server_state" => server_state_params}, socket) do
    changeset =
      socket.assigns.server_state
      |> Game.change_server_state(server_state_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"server_state" => server_state_params}, socket) do
    save_server_state(socket, socket.assigns.action, server_state_params)
  end

  defp save_server_state(socket, :edit, server_state_params) do
    case Game.update_server_state(socket.assigns.server_state, server_state_params) do
      {:ok, server_state} ->
        notify_parent({:saved, server_state})

        {:noreply,
         socket
         |> put_flash(:info, "Server state updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_server_state(socket, :new, server_state_params) do
    case Game.create_server_state(server_state_params) do
      {:ok, server_state} ->
        notify_parent({:saved, server_state})

        {:noreply,
         socket
         |> put_flash(:info, "Server state created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
