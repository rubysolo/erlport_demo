defmodule ErlportDemoWeb.PageController do
  use ErlportDemoWeb, :controller

  def index(conn, _params) do
    live_render(conn, ErlportDemoWeb.PythonView, session: %{})
  end

  def train(conn, _params) do
    live_render(conn, ErlportDemoWeb.TrainView, session: %{})
  end

  def guess(conn, _params) do
    live_render(conn, ErlportDemoWeb.OracleView, session: %{})
  end
end
