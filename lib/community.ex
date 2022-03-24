defmodule Community do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([],[]), do: :equal
  def compare(_,[]), do: :superlist
  def compare([],_), do: :sublist
  def compare(a,a), do: :equal
  def compare(a, b) when length(a) == length(b) do
  	cond do
  		hd(a) == hd(b) -> compare(tl(a),tl(b))
  		true -> :unequal
  	end
  end
  def compare(a, b) do
  	cond do
  		String.contains?(Enum.join(a,"-")<>"-", Enum.join(b,"-")<>"-") -> :superlist
  		String.contains?(Enum.join(b,"-")<>"-", Enum.join(a,"-")<>"-") -> :sublist
  		true -> :unequal
  	end
  end
end
