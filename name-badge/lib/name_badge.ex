defmodule NameBadge do
  def print(id, name, department) do
    is_department = if is_nil(department), do: "owner", else: department

    if is_nil(id) do
      "#{name} - #{String.upcase(is_department)}"
    else
      "[#{id}] - #{name} - #{String.upcase(is_department)}"
    end
  end
end
