defmodule ErlportDemoWeb.TrainView do
  use Phoenix.LiveView

  def render(assigns) do
    ErlportDemoWeb.PageView.render("train.html", assigns)
  end

  def mount(_session, socket) do
    ErlportDemo.LiveUpdates.subscribe_live_view()
    {:ok, assign(socket, last_message: "idle.")}
  end

  def handle_event("start-training", _value, socket) do
    ErlportDemo.Train.train
    {:noreply, assign(socket, last_message: "started!")}
  end

  def handle_info({_requesting_module, :training_message, msg}, socket) do
    {:noreply, assign(socket, last_message: msg)}
  end

  def handle_info(msg, socket) do
    IO.inspect(msg, label: "unmatched message:")
    {:noreply, socket}
  end
end
