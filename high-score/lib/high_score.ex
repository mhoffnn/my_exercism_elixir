defmodule HighScore do
  @initial_score 0

  def new() do
    Map.new()
  end

  def add_player(scores, name, score \\ @initial_score) do
    Map.merge(scores, %{name => score})
  end

  def remove_player(scores, name) do
    {_ok, new_map} = Map.pop(scores, name, :ok)
    new_map
  end

  def reset_score(scores, name) do
    Map.update(scores, name, @initial_score, fn _0 -> 0 end)
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, fn existing_value -> existing_value + score end)
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end
