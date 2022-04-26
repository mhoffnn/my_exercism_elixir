defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount - ((before_discount * discount) / 100)
  end

  def monthly_rate(hourly_rate, discount) do
  hourly_rate * 8 * 22
  |> apply_discount(discount)
  |> Float.ceil()
  |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discount_applyed = apply_discount(8 * hourly_rate, discount)
    |> trunc()

    Float.floor(budget / discount_applyed, 1)
  end
end
