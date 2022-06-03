defmodule RemoteControlCar do
  @enforce_keys :nickname
  defstruct battery_percentage: 100, distance_driven_in_meters: 0, nickname: "none"


  def new(nickname \\ "none")
  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car = %RemoteControlCar{}) do
    distance =
      remote_car
      |> Map.fetch!(:distance_driven_in_meters)
      |> to_string()

    distance <> " meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"

  def display_battery(remote_car = %RemoteControlCar{}) do
    battery =
      remote_car
      |> Map.fetch!(:battery_percentage)
      |> to_string()

    "Battery at " <> battery <> "%"
  end

  def drive(remote_car = %RemoteControlCar{battery_percentage: 0}), do: remote_car
  def drive(remote_car = %RemoteControlCar{}) do
    %RemoteControlCar{
      battery_percentage: remote_car.battery_percentage - 1,
      distance_driven_in_meters: remote_car.distance_driven_in_meters + 20,
      nickname: remote_car.nickname
    }
  end
end
