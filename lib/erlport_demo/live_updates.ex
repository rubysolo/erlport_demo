defmodule ErlportDemo.LiveUpdates do
  @topic inspect(__MODULE__)

  def subscribe_live_view do
    Phoenix.PubSub.subscribe(ErlportDemo.PubSub, topic(), link: true)
  end

  def notify_live_view(message) do
    Phoenix.PubSub.broadcast(ErlportDemo.PubSub, topic(), message)
  end

  defp topic, do: @topic
end
