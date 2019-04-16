defmodule ErlportDemoWeb.PythonView do
  use Phoenix.LiveView

  def render(assigns) do
    ErlportDemoWeb.PageView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, python_version: "- unknown -")}
  end

  def handle_event("get-python-version", _value, socket) do
    {:ok, pid} = :python.start()
    version = :python.call(pid, :sys, :'version.__str__', [])

    {:noreply, assign(socket, python_version: version)}
  end
end
