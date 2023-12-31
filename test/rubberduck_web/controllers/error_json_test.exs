defmodule RubberduckWeb.ErrorJSONTest do
  use RubberduckWeb.ConnCase

  test "renders 404" do
    assert RubberduckWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert RubberduckWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
