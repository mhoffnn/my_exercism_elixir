defmodule TopSecret do
  def to_ast(string) do
    {:ok, quoted} = Code.string_to_quoted(string)
    quoted
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {:def, _, code} ->
        {function, _, arguments_list} =
          fun(code)
          |> IO.inspect()

        if(function == :adjust) do
        end

        secret =
          function
          |> Atom.to_string()
          |> len(arguments_list)

        {ast, List.insert_at(acc, 0, secret)}

      {:defp, _, code} ->
        {function, _, arguments_list} = fun(code)

        secret =
          function
          |> Atom.to_string()
          |> len(arguments_list)

        {ast, List.insert_at(acc, 0, secret)}

      {_, _, _} ->
        {ast, acc}
    end
  end

  defp len(_, nil), do: ""
  defp len(_, []), do: ""
  defp len(function, list), do: String.slice(function, 0..(length(list) - 1))


  defp fun(function) do
    case List.first(function) do
      {:when, _, list} ->
        List.first(list)

      {_, _, _} ->
        List.first(function)
    end
  end

  def decode_secret_message(string) do
  ast = string
  |> to_ast()

  {:__block__, [], code} = ast
  IO.inspect(code)
  decode_secret_message_format(code)
  end

  def decode_secret_message_format([]), do: ""
  def decode_secret_message_format({:defmodule, _, arguments_list}), do: decode_secret_message_format(arguments_list)
  def decode_secret_message_format([{func, line, arguments_list} | tail]) do
    decode_secret_message_part({func, line, arguments_list}, [""]) <> decode_secret_message_format(tail)
  end
end
