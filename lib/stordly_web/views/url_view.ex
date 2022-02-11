defmodule StordlyWeb.URLView do
  use StordlyWeb, :view
  alias StordlyWeb.URLView

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, URLView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    %{data: render_one(url, URLView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    %{
      hash: StordlyWeb.Endpoint.url() <> "/" <> url.hash,
      url: url.url
    }
  end
end
