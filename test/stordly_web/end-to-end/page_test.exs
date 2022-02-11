defmodule StordlyWeb.App do
  use ExUnit.Case, async: true
  use Wallaby.Feature
  import Wallaby.Query

  feature "mount element should exists", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("#container"))
  end

  feature "page elements should exists", %{session: session} do
    session
    |> visit("/")
    |> assert_has(data("test", "title", text: "Stordly"))
    |> assert_has(data("test", "subTitle", text: "Stop sharing long URLs, shorten them today!"))
    |> assert_has(data("test", "url"))
    |> assert_has(data("test", "submit"))
  end

  feature "success message and copy button should be shown when URL is saved correctly", %{
    session: session
  } do
    session
    |> visit("/")
    |> fill_in(
      data("test", "url"),
      with: "http://example.org"
    )
    |> click(data("test", "submit"))
    |> assert_has(data("test", "success"))
    |> assert_has(data("test", "copy"))
  end

  feature "HTML5 error message should be shown when URL input is not valid and submitted using submit button",
          %{session: session} do
    session
    |> visit("/")
    |> fill_in(
      data("test", "url"),
      with: "example"
    )
    |> click(data("test", "submit"))
    |> assert_has(css("input:invalid", count: 1))
  end

  feature "HTML5 error message should be shown when URL input is empty and submitted using submit button",
          %{session: session} do
    session
    |> visit("/")
    |> click(data("test", "submit"))
    |> assert_has(css("input:invalid", count: 1))
  end

  feature "HTML5 error message should be shown when there is not input and Enter key is pressed",
          %{session: session} do
    session
    |> visit("/")
    |> send_keys(data("test", "url"), [:enter])
    |> assert_has(css("input:invalid", count: 1))
  end

  feature "form should be submitted when input is valid and Enter key is pressed", %{
    session: session
  } do
    session
    |> visit("/")
    |> fill_in(
      data("test", "url"),
      with: "http://example.org"
    )
    |> send_keys(data("test", "url"), [:enter])
    |> assert_has(data("test", "success"))
    |> assert_has(data("test", "copy"))
  end

  feature "error message should be shown when there is an error", %{session: session} do
    session
    |> visit("/")
    |> fill_in(
      data("test", "url"),
      with:
        "http://chart.apis.google.com/chart?chs=500x500&chma=0,0,100,100&cht=p&chco=FF0000%2CFFFF00%7CFF8000%2C00FF00%7C00FF00%2C0000FF&chd=t%3A122%2C42%2C17%2C10%2C8%2C7%2C7%2C7%2C7%2C6%2C6%2C6%2C6%2C5%2C5&chl=122%7C42%7C17%7C10%7C8%7C7%7C7%7C7%7C7%7C6%7C6%7C6%7C6%7C5%7C5&chdl=android%7Cjava%7Cstack-trace%7Cbroadcastreceiver%7Candroid-ndk%7Cuser-agent%7Candroid-webview%7Cwebview%7Cbackground%7Cmultithreading%7Candroid-source%7Csms%7Cadb%7Csollections%7Cactivity|Chart"
    )
    |> click(data("test", "submit"))
    |> assert_has(data("test", "error"))
  end
end
