defmodule RubberduckWeb.ServerStateLiveTest do
  use RubberduckWeb.ConnCase

  import Phoenix.LiveViewTest
  import Rubberduck.GameFixtures

  @create_attrs %{value: 42}
  @update_attrs %{value: 43}
  @invalid_attrs %{value: nil}

  defp create_server_state(_) do
    server_state = server_state_fixture()
    %{server_state: server_state}
  end

  describe "Index" do
    setup [:create_server_state]

    test "lists all server_states", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/server_states")

      assert html =~ "Listing Server states"
    end

    test "saves new server_state", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/server_states")

      assert index_live |> element("a", "New Server state") |> render_click() =~
               "New Server state"

      assert_patch(index_live, ~p"/server_states/new")

      assert index_live
             |> form("#server_state-form", server_state: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_state-form", server_state: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_states")

      html = render(index_live)
      assert html =~ "Server state created successfully"
    end

    test "updates server_state in listing", %{conn: conn, server_state: server_state} do
      {:ok, index_live, _html} = live(conn, ~p"/server_states")

      assert index_live
             |> element("#server_states-#{server_state.id} a", "Edit")
             |> render_click() =~
               "Edit Server state"

      assert_patch(index_live, ~p"/server_states/#{server_state}/edit")

      assert index_live
             |> form("#server_state-form", server_state: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_state-form", server_state: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_states")

      html = render(index_live)
      assert html =~ "Server state updated successfully"
    end

    test "deletes server_state in listing", %{conn: conn, server_state: server_state} do
      {:ok, index_live, _html} = live(conn, ~p"/server_states")

      assert index_live
             |> element("#server_states-#{server_state.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#server_states-#{server_state.id}")
    end
  end

  describe "Show" do
    setup [:create_server_state]

    test "displays server_state", %{conn: conn, server_state: server_state} do
      {:ok, _show_live, html} = live(conn, ~p"/server_states/#{server_state}")

      assert html =~ "Show Server state"
    end

    test "updates server_state within modal", %{conn: conn, server_state: server_state} do
      {:ok, show_live, _html} = live(conn, ~p"/server_states/#{server_state}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Server state"

      assert_patch(show_live, ~p"/server_states/#{server_state}/show/edit")

      assert show_live
             |> form("#server_state-form", server_state: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#server_state-form", server_state: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/server_states/#{server_state}")

      html = render(show_live)
      assert html =~ "Server state updated successfully"
    end
  end
end
