defmodule StordlyWeb.PageController do
  use StordlyWeb, :controller
  alias Stordly.URLS

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"hash" => hash}) do
    case URLS.get_url_by_hash(hash) do
      nil -> redirect(conn, to: "/")
      url -> redirect(conn, external: url)
    end
  end
end
