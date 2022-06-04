defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ [maximum_price: 100])

  def get_combinations(tops, bottoms, options) do
    for x <- tops,
        y <- bottoms,
        x.price + y.price < max_value(options),
        x.base_color != y.base_color,
        do: {x, y}
  end

  defp max_value([maximum_price: max_value]), do: max_value
  defp max_value(_), do: 100
end
