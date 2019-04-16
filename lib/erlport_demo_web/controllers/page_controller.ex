defmodule ErlportDemoWeb.PageController do
  use ErlportDemoWeb, :controller

  def index(conn, _params) do
    live_render(conn, ErlportDemoWeb.PythonView, session: %{})
  end
end
