defmodule Stordly.URLS.URL do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :hash, :string
    field :url, :string

    timestamps()
  end

  def generate_hash(url) do
    :crypto.hash(:sha256, url)
    |> Base.encode16()
    |> String.slice(0, 6)
  end

  def validate_url(changeset, field) do
    validate_change(changeset, field, fn _current_field, value ->
      case URI.new(value) do
        {:ok, %URI{scheme: nil}} ->
          [{field, "URL scheme is malformed."}]

        {:ok, %URI{host: nil}} ->
          [{field, "URL host is malformed."}]

        {:ok, %URI{host: host}} ->
          case :inet.gethostbyname(Kernel.to_charlist(host)) do
            {:ok, _} -> []
            {:error, _} -> [{field, "URL host is malformed."}]
          end

        {:error, _part} ->
          [{field, "URL is malformed."}]
      end
    end)
  end

  @doc false
  def changeset(url, attrs) do
    values = %{url: attrs, hash: generate_hash(attrs)}

    url
    |> cast(values, [:hash, :url])
    |> validate_length(:url,
      max: 255,
      message: "URL is too long, should be at most 255 characters."
    )
    |> validate_url(:url)
    |> validate_required([:hash, :url])
    |> unique_constraint(:url)
    |> unique_constraint(:hash)
  end
end
