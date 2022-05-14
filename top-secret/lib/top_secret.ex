defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({operation, _, args} = ast, acc)
      when operation in [:def, :defp] do
    {f_name, f_arity} = get_f_name_arity(args)
    {ast, [String.slice(to_string(f_name), 0, f_arity) | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp get_f_name_arity(def_args) do
    case def_args do
      [{:when, _, args} | _] -> get_f_name_arity(args)
      [{name, _, args} | _] when is_list(args) -> {to_string(name), length(args)}
      [{name, _, args} | _] when is_atom(args) -> {to_string(name), 0}
    end
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)

    acc
    |> Enum.reverse()
    |> Enum.join("")
  end
end
