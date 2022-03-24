defmodule SublistTest do
  use ExUnit.Case
  doctest Original
  doctest Parallel

  @tag :benchmark
  test "benchmark" do
    list = Enum.to_list(1..10000) |> Enum.shuffle()
    sublist = Enum.chunk_every(list, 4) |> Enum.random()

    Benchee.run(%{
      "original" => fn -> Original.compare(sublist, list) end,
      "parallel" => fn -> Parallel.compare(sublist, list) end,
      "community" => fn -> Community.compare(sublist, list) end
    })
  end
end
