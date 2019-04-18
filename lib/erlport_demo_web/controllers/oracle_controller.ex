defmodule ErlportDemoWeb.OracleController do
  use ErlportDemoWeb, :controller

  alias ErlportDemo.Oracle

  def show(conn, %{"image" => "data:image/png;base64," <> encoded}) do
    {:ok, guess} = Oracle.guess(encoded)
    json conn, %{guess: guess}
  end
end
