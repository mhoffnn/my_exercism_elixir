defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path
    |> String.split(".")
    |> from_path(data)
  end

  defp from_path([], data), do: data
  defp from_path([head | tail], data), do: from_path(tail, data[head])

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
