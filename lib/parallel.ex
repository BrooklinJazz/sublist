defmodule Parallel do
  @doc """
  iex> Parallel.compare([], [])
  :equal
  iex> Parallel.compare([1, 2], [1, 2, 3])
  :sublist
  iex> Parallel.compare([1, 2], [])
  :superlist
  iex> Parallel.compare([1, 2], [3])
  :unequal
  iex> Parallel.compare([1, 2, 3], [1, 2])
  :superlist
  """

  def compare(list_a, list_b) do
    is_sublist = Task.async(__MODULE__, :is_sublist?, [list_a, list_a, list_b])
    is_superlist = Task.async(__MODULE__, :is_sublist?, [list_b, list_b, list_a])
    is_equal = Task.async(Kernel, :===, [list_a, list_b])

    cond do
      Task.await(is_equal) -> :equal
      Task.await(is_sublist) -> :sublist
      Task.await(is_superlist) -> :superlist
      true -> :unequal
    end
  end

  @doc """
  iex> Parallel.is_sublist?([1, 2], [1, 2], [])
  false
  iex> Parallel.is_sublist?([], [], [1, 2])
  true
  iex> Parallel.is_sublist?([1, 2], [1, 2], [1, 2, 3])
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
