defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, native_date} = NaiveDateTime.from_iso8601(string)
    native_date
  end

  def before_noon?(datetime) do
    if datetime.hour < 12 do
      true
    else
      false
    end
  end

  defp total_days(noon?) do
    if noon? do
      28
    else
      29
    end
  end

  def return_date(checkout_datetime) do
    checkout_datetime
    |> NaiveDateTime.add(86400 * total_days(before_noon?(checkout_datetime)), :second)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> Date.diff(planned_return_date)
    |> smaller()
  end

  defp smaller(days_late) do
    if days_late > 0, do: days_late, else: 0
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> first?()
  end

  defp first?(day_number), do: if(day_number == 1, do: true, else: false)

  def calculate_late_fee(checkout, return, rate) do
    day_return = datetime_from_string(return)

    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(day_return)
    |> fee(day_return, rate)
  end

  defp fee(0, _day_return, _rate), do: 0

  defp fee(days_late, day_return, rate) do
    if monday?(day_return) do
      (days_late * rate / 2)
      |> Float.floor(0)
    else
      days_late * rate
    end
  end
end
