defmodule Stordly.URLS do
  @moduledoc """
  The URLS context.
  """

  import Ecto.Query, warn: false
  alias Stordly.Repo

  alias Stordly.URLS.URL

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %URL{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url!(id), do: Repo.get!(URL, id)

  def get_url_by_hash(hash) do
    URL
    |> where([u], u.hash == ^hash)
    |> select([u], u.url)
    |> Repo.one()
  end

  def get_url_by_url(url) do
    URL |> where([u], u.url == ^url) |> Repo.one()
  end

  @doc """
  Creates a url.

  ## Examples

      iex> create_or_get_url(url)
      {:ok, %URL{}}

      iex> create_or_get_url(bad_url)
      {:error, %Ecto.Changeset{}}

  """
  def create_or_get_url(attrs \\ %{}) do
    case get_url_by_url(attrs) do
      nil ->
        %URL{}
        |> URL.changeset(attrs)
        |> Repo.insert()

      url ->
        {:ok, url}
    end
  end
end
