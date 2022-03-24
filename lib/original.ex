defmodule Original do
  @doc """
  iex> Original.compare([], [])
  :equal
  iex> Original.compare([1, 2], [1, 2, 3])
  :sublist
  iex> Original.compare([1, 2], [])
  :superlist
  iex> Original.compare([1, 2], [3])
  :unequal
  iex> Original.compare([1, 2, 3], [1, 2])
  :superlist
  """

  def compare(list_a, list_b) do
    cond do
      list_a === list_b -> :equal
      is_sublist?(list_a, list_a, list_b) -> :sublist
      is_sublist?(list_b, list_b, list_a) -> :superlist
      true -> :unequal
    end
  end

  @doc """
  iex> Original.is_sublist?([1, 2], [1, 2], [])
  false
  iex> Original.is_sublist?([], [], [1, 2])
  true
  iex> Original.is_sublist?([1, 2], [1, 2], [1, 2, 3])
  true
  """
  def is_sublist?(_, [], _), do: true
  def is_sublist?(_, _, []), do: false

  def is_sublist?(list_a, [a | tail_a], [b | tail_b]) do
    if a === b do
      is_sublist?(list_a, tail_a, tail_b)
    else
      is_sublist?(list_a, list_a, tail_b)
    end
  end
end
