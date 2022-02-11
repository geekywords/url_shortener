defmodule StordlyWeb.URLControllerTest do
  use StordlyWeb.ConnCase

  @create_attrs "http://example.org"
  @invalid_attrs "example"

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create url" do
    test "renders url when data is valid", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), url: @create_attrs)

      assert %{
               "url" => "http://example.org"
             } = json_response(conn, 201)["data"]

      assert json_response(conn, 201)["data"] |> Map.get("hash")
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), url: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
