defmodule ErlportDemoWeb.OracleView do
  use Phoenix.LiveView

  def render(assigns) do
    ErlportDemoWeb.PageView.render("guess.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, guess: nil)}
  end
end
