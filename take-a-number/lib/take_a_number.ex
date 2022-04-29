defmodule TakeANumber do
  def start() do
    spawn(fn -> loop(0) end)
  end

  defp loop(count) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, count)
        loop(count)

      {:take_a_number, sender_pid} ->
        send(sender_pid, count + 1)
        loop(count + 1)

      :stop ->
        nil

      _ ->
        loop(count)
    end
  end
end
