defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  def encode(list), do: do_encode(list)

  defp do_encode([]), do: <<>>
  defp do_encode([head|tail]), do: <<encode_nucleotide(head)::4, do_encode(tail)::bitstring>>

  def decode(bitstring), do: do_decode(bitstring)

  defp do_decode(<<0::0>>), do: ''
  defp do_decode(<<value::4, rest::bitstring>>), do: [decode_nucleotide(value) | do_decode(rest)]
end
