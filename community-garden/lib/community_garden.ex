# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ [])

  def start(opts) do
    Agent.start(fn -> [] end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state end)
  end

  def register(pid, register_to) do
    Agent.update(pid, fn state ->
      List.insert_at(state, 0, %Plot{
        plot_id: String.length(register_to) * (length(state) + 1),
        registered_to: register_to
      })
    end)

    pid
    |> list_registrations()
    |> List.first()
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      for x <- state, 
          x.plot_id != plot_id,
          do: x
    end)
  end

  def get_registration(pid, plot_id) do
    pid
    |> list_registrations()
    |> get_plot_by_id(plot_id)
  end

  defp get_plot_by_id([], _), do: {:not_found, "plot is unregistered"}

  defp get_plot_by_id([head | tail], id) do
    if head.plot_id == id do
      head
    else
      get_plot_by_id(tail, id)
    end
  end
end
