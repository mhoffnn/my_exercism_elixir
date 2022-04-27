defmodule Username do
  def sanitize([]), do: []

  def sanitize([head | tail]) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

    case head do
      head when head >= ?a and head <= ?z ->
        [head | sanitize(tail)]

      head when head == ?_ ->
        [head | sanitize(tail)]

      head when head === ?ä ->
        [?a, ?e | sanitize(tail)]

      head when head == ?ö ->
        [?o, ?e | sanitize(tail)]

      head when head == ?ü ->
        [?u, ?e | sanitize(tail)]

      head when head == ?ß ->
        [?s, ?s | sanitize(tail)]

      head when is_number(head) == true ->
        sanitize(tail)
    end
  end
end
