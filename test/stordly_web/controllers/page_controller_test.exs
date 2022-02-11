defmodule StordlyWeb.PageControllerTest do
  use StordlyWeb.ConnCase

  test "GET / should render page with mounting element", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<main id=\"container\""
  end

  test "GET /:hash should redirect to URL when hash is valid", %{conn: conn} do
    url = "http://example.org"
    conn = post(conn, Routes.url_path(conn, :create), url: url)

    hash = json_response(conn, 201)["data"] |> Map.get("hash")

    conn = get(conn, hash)
    assert redirected_to(conn, 302) =~ url
  end

  test "GET /:hash should redirect to / when hash is invalid", %{conn: conn} do
    conn = get(conn, "/invalid")
    assert redirected_to(conn, 302) =~ "/"
  end
end
