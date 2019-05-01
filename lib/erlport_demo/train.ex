defmodule ErlportDemo.Train do
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    python_path = Application.app_dir(:erlport_demo, "priv/python")
    {:ok, pid} = :python.start(python_path: String.to_charlist(python_path))
    {:ok, %{python: pid, messages: []}}
  end

  def train do
    GenServer.call(__MODULE__, :train)
  end

  def handle_call(:train, _from, %{python: pid}=state) do
    :ok = :python.call(pid, :train, :register_handler, [self()])
    :python.cast(pid, :go)
    {:reply, :ok, state}
  end

  def handle_info({:msg, msg}, state) do
    IO.inspect(msg, label: "got message")
    ErlportDemo.LiveUpdates.notify_live_view({__MODULE__, :training_message, msg})
    {:noreply, %{state | messages: [msg | state.messages]}}
  end
end
