defmodule ErlportDemo.Oracle do
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    python_path = Application.app_dir(:erlport_demo, "priv/python")
    {:ok, pid} = :python.start(python_path: String.to_charlist(python_path))
    {:ok, %{python: pid, messages: []}}
  end

  def guess(encoded) do
    GenServer.call(__MODULE__, {:guess, encoded})
  end

  def handle_call({:guess, encoded}, _from, %{python: pid}=state) do
    resp = :python.call(pid, :oracle, :guess, [encoded])
    {:reply, resp, state}
  end
end
