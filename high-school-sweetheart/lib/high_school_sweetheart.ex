defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.trim(name)
    |> String.first()
  end

  def initial(name) do
    name = first_letter(name)
    |> String.upcase()
    name <> "."
  end

  defp initials_print([first_name, second_name]) do
    initial(first_name) <> " " <> initial(second_name)
  end

  def initials(full_name) do
    String.trim(full_name)
    |> String.split()
    |> initials_print()
  end

  def pair(full_name1, full_name2) do
   """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{initials(full_name1)}  +  #{initials(full_name2)}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
