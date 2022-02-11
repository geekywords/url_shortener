defmodule Stordly.URLSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Stordly.URLS` context.
  """

  @doc """
  Generate a unique url hash.
  """
  def unique_url_hash, do: "some hash#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique url url.
  """
  def unique_url_url, do: "http://example.org/#{System.unique_integer([:positive])}"

  @doc """
  Generate a url.
  """
  def url_fixture() do
    {:ok, url} =
      unique_url_url()
      |> Stordly.URLS.create_or_get_url()

    url
  end
end
