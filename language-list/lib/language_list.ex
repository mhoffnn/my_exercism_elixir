defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    List.insert_at(list, 0, language)
  end

  def remove(list) do
    List.delete_at(list, 0)
  end

  def first(list) do
    List.first list
  end

  def count(list) do
    length(list)
  end

  def functional_list?([head|tail]) do
    if(head == "Elixir") do
      true
    else if tail == [] do
      false
    else
      functional_list?(tail)
    end
    end
  end
end
