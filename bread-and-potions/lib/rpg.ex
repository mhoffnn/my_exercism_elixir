defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, caracter)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_, character) do
      {
        nil,
        %RPG.Character{
          mana: character.mana,
          health: character.health + 5
        }
      }
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(item, character) do
      {
        %RPG.EmptyBottle{},
        %RPG.Character{
          health: character.health,
          mana: character.mana + item.strength,
        }
      }
    end
  end

  defimpl Edible, for: Poison do
    def eat(_, character) do
      {
        %RPG.EmptyBottle{},
        %RPG.Character{
          health: 0,
          mana: character.mana
        }
      }
    end
  end
end
