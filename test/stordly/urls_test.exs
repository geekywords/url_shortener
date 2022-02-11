defmodule Stordly.URLSTest do
  use Stordly.DataCase

  alias Stordly.URLS

  describe "urls" do
    alias Stordly.URLS.URL

    import Stordly.URLSFixtures

    @invalid_attrs "example"

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert URLS.get_url!(url.id) == url
    end

    test "create_or_get_url/1 with valid data creates a url" do
      valid_attrs = "http://example.org"

      assert {:ok, %URL{} = url} = URLS.create_or_get_url(valid_attrs)
      assert url.url == "http://example.org"
    end

    test "create_or_get_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = URLS.create_or_get_url(@invalid_attrs)
    end
  end
end
