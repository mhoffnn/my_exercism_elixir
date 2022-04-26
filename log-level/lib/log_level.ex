defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 and legacy? == false ->
        :trace
      level == 1 ->
        :debug
      level == 2 ->
        :info
      level == 3 ->
        :warning
      level == 4 ->
        :error
      level == 5 and legacy? == false ->
        :fatal
      true ->
        :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    cond do
      level == 4 or level == 5 and legacy? == false  ->
        :ops
      (level >= 5 or level == 0) and legacy? == true ->
        :dev1
      level == 6 ->
        :dev2
      true ->
        :false
  end
end
end
