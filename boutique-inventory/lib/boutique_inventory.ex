defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(& &1.price, &<=/2)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(fn x -> x[:price] == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn x ->
      Map.replace(
        x,
        :name,
        String.replace(
          x[:name],
          old_word,
          new_word
        )
      )
    end)
  end

  def increase_quantity(item, count) do
    item
    |> Enum.into(%{}, fn {k, v} -> increase({k, v}, count) end)
  end

  defp increase({:quantity_by_size, value}, sum) do
    quantity =
      value
      |> Map.new(fn {k, v} -> {k, v + sum} end)

    {:quantity_by_size, quantity}
  end

  defp increase({k, v}, _), do: {k, v}

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Enum.reduce(0, fn {_, v}, acc -> v + acc end)
  end
end
