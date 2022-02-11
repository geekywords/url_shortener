defmodule StordlyWeb.URLController do
  use StordlyWeb, :controller

  alias Stordly.URLS
  alias Stordly.URLS.URL

  action_fallback StordlyWeb.FallbackController

  def create(conn, %{"url" => url_params}) do
    with {:ok, %URL{} = url} <- URLS.create_or_get_url(url_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end
end
